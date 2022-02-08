class MCSDownloadProgress {
  final String originalUrl;
  final int? totalSize;
  final int downloaded;

  double? get progress {
    if (totalSize == null || downloaded > totalSize!) return null;
    return downloaded / totalSize!;
  }

  MCSDownloadProgress(this.originalUrl, this.totalSize, this.downloaded);
}