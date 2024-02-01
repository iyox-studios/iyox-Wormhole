use crate::api::{Events, TUpdate, Value};
use flutter_rust_bridge::StreamSink;
use std::collections::HashMap;
use std::fs::{metadata, File};
use std::io::{Read, Write};
use std::path::{Path, PathBuf};
use std::rc::Rc;
use zip::write::FileOptions;
use zip::CompressionMethod;

fn _list_files(vec: &mut Vec<PathBuf>, path: &Path) -> anyhow::Result<()> {
    if path.is_dir() {
        let paths = path.read_dir()?;
        for path_result in paths {
            let full_path = path_result?.path();
            if metadata(&full_path)?.is_dir() {
                // ignore maybe failing subfolder
                let _ = _list_files(vec, &full_path);
            } else {
                vec.push(full_path);
            }
        }
    }
    Ok(())
}

pub fn list_dir(folder_path: String) -> anyhow::Result<HashMap<String, String>> {
    let mut m = HashMap::new();
    let mut files = Vec::new();

    // todo check if error handled correctly here
    _list_files(&mut files, folder_path.as_str().as_ref())?;

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

pub fn create_zip_file(
    files: HashMap<String, String>,
    temp_file_path: String,
    actions: Rc<StreamSink<TUpdate>>,
) -> anyhow::Result<String> {
    let n = fastrand::u32(..);

    let mut temp_file = PathBuf::from(temp_file_path);

    temp_file.push(format!("wormhole-{}", n));
    temp_file.set_extension("zip");

    let file = File::create(temp_file.clone())?;
    let mut zip = zip::ZipWriter::new(file);
    let options = FileOptions::default()
        .compression_method(CompressionMethod::Deflated)
        .unix_permissions(0o755);

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
