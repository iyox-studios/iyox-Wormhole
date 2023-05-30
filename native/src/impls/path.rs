use std::path::PathBuf;

/// find next free filepath on fs (padding with (copy))
pub fn find_free_filepath(path: PathBuf) -> Option<PathBuf> {
    // if path is free terminate recursion
    if !path.exists() {
        return Some(path);
    }

    // get extension or empty string if no one exists
    let ext = path.extension().and_then(|x| x.to_str()).unwrap_or("");

    match path.file_stem().and_then(|x| x.to_str()) {
        None => None,
        Some(v) => {
            let name = if ext.is_empty() {
                format!("{}(copy)", v)
            } else {
                format!("{}(copy).{}", v, ext)
            };
            let mut path = path.clone();
            path.set_file_name(name.as_str());
            // recursively call this function until a free path is found
            return find_free_filepath(path.to_path_buf());
        }
    }
}
