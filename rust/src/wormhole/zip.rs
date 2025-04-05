use std::{collections::HashMap, fs::{self, metadata, File}, io::{Read, Write}, path::PathBuf, rc::Rc};

use zip::{write::SimpleFileOptions, ZipWriter};

use crate::{api::{Events, TUpdate, Value}, frb_generated::StreamSink};


pub fn create_zip_file(
    files: HashMap<String, String>,
    temp_file_path: String,
    actions: Rc<StreamSink<TUpdate>>
) -> anyhow::Result<String> {
    let rand = fastrand::u32(..);

    let mut temp_file = PathBuf::from(temp_file_path);
    temp_file.push(format!("wormhole-{}", rand));
    temp_file.set_extension("zip");

    let file = File::create(temp_file.clone())?;
    let mut zip = ZipWriter::new(file);
    let options = SimpleFileOptions::default();

    // send zip start event + nr of total files
    actions.add(TUpdate::new(
        Events::ZipFilesTotal,
        Value::Int(files.len() as i32),
    ));

    let mut buffer = Vec::new();

    let mut file_counter = 1;

     // zip files
     for (fs_path, zip_path) in files.into_iter() {
        actions.add(TUpdate::new(Events::ZipFiles, Value::Int(file_counter)));
        file_counter += 1;

        zip.start_file(zip_path, options)?;
        let mut f = File::open(fs_path)?;

        f.read_to_end(&mut buffer)?;
        zip.write_all(&buffer)?;
        buffer.clear();
    }

    zip.finish()?;

    let tmp_file_name = temp_file
        .to_str()
        .ok_or(anyhow::Error::msg("invalid tempfile path"))?
        .to_string();
    Ok(tmp_file_name)
}

fn walk_dir(dir: PathBuf) -> Result<Vec<PathBuf>, anyhow::Error> {
    let mut dirs = vec![dir];
    let mut files = vec![];

    while !dirs.is_empty() {
        let mut dir_iter = fs::read_dir(dirs.remove(0))?;

        while let Some(entry) = dir_iter.next() {
            let entry_path_buf = entry.unwrap().path();
            tracing::debug!("ASD: {:?}", entry_path_buf);

            if entry_path_buf.is_dir() {
                dirs.push(entry_path_buf);
            } else {
                files.push(entry_path_buf);
            }
        }
    }

    Ok(files)
}


pub fn list_dir(folder_path: String) -> anyhow::Result<HashMap<String, String>> {
    let mut m = HashMap::new();

    let files = walk_dir(folder_path.clone().into())?;

    for path in files {
        if metadata(&path)?.is_file() {
            let pathstr = path
                .to_str()
                .ok_or(anyhow::Error::msg("invalid subpath str"))?
                .to_string();
            let subpath = pathstr.replace(&folder_path, "");

            m.insert(pathstr, subpath);
        }
    }

    Ok(m)
}
