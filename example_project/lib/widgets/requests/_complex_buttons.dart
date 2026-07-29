part of 'request_buttons_section.dart';

class _ComplexButtons extends StatelessWidget
    with LoggerMixin<_ComplexButtons> {
  _ComplexButtons({
    required this.invoker,
  });

  final DioNetworkInvoker invoker;

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      children: [
        _RequestButton(
          label: 'Get Widgets',
          icon: Icons.widgets,
          onPressed: () async {
            final result = await invoker.send(GetWidgetsCommand(page: 1));
            _logNetworkResult(
              log,
              'Get widgets',
              result,
              successFormatter: (data) => data.toJson(),
            );
          },
        ),
        _RequestButton(
          label: 'Patch Record #1',
          icon: Icons.auto_fix_high,
          onPressed: () async {
            final result = await invoker.send(
              PatchRecordCommand(
                id: '1',
                body: {'field': 'patched_value'},
              ),
            );
            _logNetworkResult(log, 'Patch record', result);
          },
        ),
        _RequestButton(
          label: 'Category Tree',
          icon: Icons.account_tree,
          onPressed: () async {
            final result = await invoker.send(
              ProcessCategoryTreeCommand(
                categoryNode: CategoryNode(
                  categoryName: 'Root',
                  subCategories: [
                    CategoryNode(categoryName: 'Child A'),
                    CategoryNode(
                      categoryName: 'Child B',
                      subCategories: [
                        CategoryNode(categoryName: 'Grandchild B1'),
                      ],
                    ),
                  ],
                ),
              ),
            );
            _logNetworkResult(
              log,
              'Process category tree',
              result,
              successFormatter: (data) => data.toJson(),
            );
          },
        ),
      ],
    );
  }
}
