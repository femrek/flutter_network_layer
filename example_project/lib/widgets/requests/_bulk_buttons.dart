part of 'request_buttons_section.dart';

class _BulkButtons extends StatelessWidget with LoggerMixin<_BulkButtons> {
  _BulkButtons({required this.invoker});

  final DioNetworkInvoker invoker;

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      children: [
        _RequestButton(
          label: 'Bulk Download',
          icon: Icons.download,
          onPressed: () async {
            final result = await invoker.send(
              BulkDownloadCommand(datasetId: 'sample-dataset'),
            );
            _logNetworkResult(log, 'Bulk download', result);
          },
        ),
        _RequestButton(
          label: 'Bulk Upload (Image)',
          icon: Icons.upload,
          onPressed: () async {
            final dir = await getApplicationCacheDirectory();
            final filePath = '${dir.path}/hn_ss.jpg';
            final file = File(filePath);
            if (!file.existsSync()) {
              log.severe('File not found. download the image first');
              return;
            }
            final result = await invoker.send(
              BulkUploadCommand(
                file: FileMultipartFileSchema(
                  filename: 'hn_ss.jpg',
                  filePath: filePath,
                  length: file.lengthSync(),
                ),
                metadata: UploadMetadata(
                  overwrite: false,
                  targetTable: 'sample_table',
                ),
              ),
            );

            _logNetworkResult(
              log,
              'Bulk upload',
              result,
              successFormatter: (data) => data.toJson(),
            );
          },
        ),
        _RequestButton(
          label: 'Get Job Status',
          icon: Icons.pending_actions,
          onPressed: () async {
            final result = await invoker.send(
              GetJobStatusCommand(
                jobId: '1',
                level: GetJobStatusLevelEnum.FULL,
              ),
            );
            _logNetworkResult(log, 'Get job status', result);
          },
        ),
        _RequestButton(
          label: 'Image Download',
          icon: Icons.image,
          onPressed: () async {
            final dir = await getApplicationCacheDirectory();
            final filePath = '${dir.path}/hn_ss.jpg';
            final result = await invoker.send(
              GetSampleImageCommand(
                binaryResponseType: FileBinaryResponse(filePath),
              ),
            );
            _logNetworkResult(log, 'Image download', result);
          },
        ),
      ],
    );
  }
}
