part of 'screen_home.dart';

mixin _MixinHome on State<ScreenHome> {
  late final INetworkInvoker _networkInvoker;

  @override
  void initState() {
    super.initState();
    _networkInvoker = GetIt.I<INetworkInvoker>();
  }

  Future<void> _getTodo1() async {
    final response = await _networkInvoker.request(RequestGetTodo(id: 1));
    response.when(
      success: (response) {
        setState(() {
          _data = response.data.toString();
        });
      },
      error: (response) {
        setState(() {
          _data = 'Failed to get todo 1';
        });
      },
    );
  }

  Future<void> _getTodos() async {
    final response = await _networkInvoker.request(RequestGetTodos());
    response.when(
      success: (response) {
        setState(() {
          _data = response.data.toString();
        });
      },
      error: (response) {
        setState(() {
          _data = 'Failed to get todos';
        });
      },
    );
  }

  Future<void> _getPost1() async {
    final response = await _networkInvoker.request(RequestGetPost(id: 1));
    response.when(
      success: (response) {
        setState(() {
          _data = response.data.toString();
        });
      },
      error: (response) {
        setState(() {
          _data = 'Failed to get post 1';
        });
      },
    );
  }

  Future<void> _postAPost() async {
    final response = await _networkInvoker.request(RequestPostPost(
      userId: 1,
      title: 'foo',
      body: 'bar',
    ));
    response.when(
      success: (response) {
        setState(() {
          _data = response.data.toString();
        });
      },
      error: (response) {
        setState(() {
          _data = 'Failed to post a post';
        });
      },
    );
  }

  String _data = '';
}
