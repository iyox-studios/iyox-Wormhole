// error types that might occur in TUpdate error
pub enum ErrorType {
    /// user passed invalid filepath
    InvalidFilename,
    /// no free filepath could be found
    NoFilePathFound,
    /// failed connecting to rendezvous server
    ConnectionError,
    /// error while requesting a file transfer
    FileRequestError,
    /// error while opening the receive file
    FileOpen,
    /// error during file transfer
    TransferError,
    /// error while connecting clients
    TransferConnectionError,
    /// error creating zip temp file
    ZipFileError,
}
