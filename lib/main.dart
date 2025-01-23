import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final PageController _controller = PageController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: PageControllerProvider(
          pageController: _controller,
          child: LayoutBuilder(builder: (context, constraints) {
            if (constraints.maxWidth < 600) {
              return const PageViewComponent();
            } else {
              return Container(child: const PageViewComponent());
            }
          }),
        ),
      ),
    );
  }
}

class PageControllerProvider extends InheritedWidget {
  final PageController pageController;

  const PageControllerProvider({
    super.key,
    required this.pageController,
    required super.child,
  });

  static PageController? of(BuildContext context) {
    final PageControllerProvider? result =
        context.dependOnInheritedWidgetOfExactType<PageControllerProvider>();
    return result?.pageController;
  }

  @override
  bool updateShouldNotify(PageControllerProvider oldWidget) {
    return oldWidget.pageController != pageController;
  }
}

class PageViewComponent extends StatelessWidget {
  const PageViewComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: PageControllerProvider.of(context),
      children: [
        Container(
          color: Colors.red,
        ),
        Container(
          color: Colors.green,
        ),
        Container(
          color: Colors.blue,
        ),
      ],
    );
  }
}
