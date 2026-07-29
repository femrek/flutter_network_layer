part of 'request_buttons_section.dart';

class _CrudButtons extends StatelessWidget with LoggerMixin<_CrudButtons> {
  _CrudButtons({required this.invoker});

  final DioNetworkInvoker invoker;

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      children: [
        _RequestButton(
          label: 'List Tables',
          icon: Icons.list,
          onPressed: () async {
            final result = await invoker.send(
              ListTablesCommand(
                start: 0,
                end: 10,
                allParams: {},
              ),
            );
            _logNetworkResult(
              log,
              'List tables',
              result,
              successFormatter: (data) =>
                  data.items.map((item) => item.toJson()).join(', '),
            );
          },
        ),
        _RequestButton(
          label: 'Get Table #1',
          icon: Icons.search,
          onPressed: () async {
            final result = await invoker.send(GetTableCommand(id: 1));
            _logNetworkResult(
              log,
              'Get table',
              result,
              successFormatter: (data) => data.toJson(),
            );
          },
        ),
        _RequestButton(
          label: 'Create Table',
          icon: Icons.add,
          onPressed: () async {
            final result = await invoker.send(
              CreateTableCommand(
                tableCreateDTO: TableCreateDTO(
                  name: 'New Table',
                  capacity: 4,
                ),
              ),
            );
            _logNetworkResult(
              log,
              'Create table',
              result,
              successFormatter: (data) => data.toJson(),
            );
          },
        ),
        _RequestButton(
          label: 'Update Table #1',
          icon: Icons.edit,
          onPressed: () async {
            final result = await invoker.send(
              UpdateTableCommand(
                id: 1,
                requestBody: {'name': 'Updated Table', 'capacity': 8},
              ),
            );
            _logNetworkResult(
              log,
              'Update table',
              result,
              successFormatter: (data) => data.toJson(),
            );
          },
        ),
        _RequestButton(
          label: 'Delete Table #1',
          icon: Icons.delete,
          onPressed: () async {
            final result = await invoker.send(DeleteTableCommand(id: 1));
            _logNetworkResult(log, 'Delete table', result);
          },
        ),
        _RequestButton(
          label: 'Get Many [1,2,3]',
          icon: Icons.checklist,
          onPressed: () async {
            final result = await invoker.send(
              GetManyTablesCommand(id: [1, 2, 3]),
            );
            _logNetworkResult(log, 'Get many tables', result);
          },
        ),
        _RequestButton(
          label: 'Delete Many [1,2]',
          icon: Icons.delete_sweep,
          onPressed: () async {
            final result = await invoker.send(
              DeleteManyTablesCommand(id: [1, 2]),
            );
            _logNetworkResult(log, 'Delete many tables', result);
          },
        ),
        _RequestButton(
          label: 'Update Many [1,2]',
          icon: Icons.edit_note,
          onPressed: () async {
            final result = await invoker.send(
              UpdateManyTablesCommand(
                id: [1, 2],
                requestBody: {'status': 'reserved'},
              ),
            );
            _logNetworkResult(log, 'Update many tables', result);
          },
        ),
        _RequestButton(
          label: 'Get Ref (category/1)',
          icon: Icons.link,
          onPressed: () async {
            final result = await invoker.send(
              GetManyReferenceByTablesCommand(
                target: 'category',
                targetId: '1',
                start: 0,
                end: 10,
                allParams: {},
              ),
            );
            _logNetworkResult(log, 'Get many reference by tables', result);
          },
        ),
      ],
    );
  }
}
