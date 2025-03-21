// possible events that might be passed back to frontend
pub enum Events {
    /// Passphrase : String
    Code,
    /// Total bytes to transfer : i32
    Total,
    /// bytes already sent : i32
    Sent,
    /// error : Error or ErrorValue
    Error,
    /// Connecting to mailbox server
    Connecting,
    /// transfer finished : String
    Finished,
    /// type of con : Connectiontype
    ConnectionType,
    /// indicate start of transaction : i32
    StartTransfer,
    /// indicates start of zipping process and total amount of files to zip
    ZipFilesTotal,
    /// number of already zipped files
    ZipFiles,
}
