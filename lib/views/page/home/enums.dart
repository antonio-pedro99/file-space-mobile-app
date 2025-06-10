enum PathType { folder, file }

enum FileType { music, image, video, document, other, folder }

enum ContentTypes { media, document, other, folder }

class AppFileSupportedExtensions {
  static const List<String> media = [
    'mp4',
    'mkv',
    'avi',
    'mov'
        'application/vnd.google-apps.photo',
    'application/vnd.google-apps.video',
    'application/vnd.google-apps.audio',
    'image/jpeg',
    'image/png',
    'video/mp4',
    'video/avi',
    'video/mkv',
  ];
  static const List<String> docs = [
    'pdf',
    'doc',
    'docx',
    'ppt',
    'pptx',
    'xls',
    'xlsx',
    'application/vnd.google-apps.document',
    'application/vnd.google-apps.spreadsheet',
    'application/vnd.google-apps.presentation',
    'application/vnd.google-apps.form',
    'application/vnd.google-apps.script',
    'application/vnd.google-apps.drawing',
    'application/pdf',
  ];

  static const List<String> other = [
    'zip',
    'rar',
    '7z',
    'tar',
    'gz',
    'application/zip',
    'application/x-rar-compressed',
    'application/x-7z-compressed',
    'application/x-tar',
    'application/gzip',
  ];

  static const List<String> folder = ['application/vnd.google-apps.folder'];
}
