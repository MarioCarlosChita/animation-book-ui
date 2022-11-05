import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Alignment> _aligment;
  late AnimationController _controllerContainer;
  late Animation<double> _containerSize;
  double widthDevice = 120;
  double heightDevice = 120;
  bool wasAnimationCompleted = false;
  bool isVisibleContainer = false;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    _aligment =
        Tween<Alignment>(begin: Alignment.center, end: Alignment.topLeft)
            .animate(_controller);

    _controllerContainer = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    _containerSize =
        Tween<double>(begin: 0, end: 1).animate(_controllerContainer);

    // _controller.addListener(_onListenAnimation);
    _controller.addStatusListener(_onListenAnimation);

    _controllerContainer.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        setState(() {
          wasAnimationCompleted = false;
        });
      }
    });

    super.initState();
  }

  void dispose() {
    _controller.dispose();
    // _controller.removeListener(_onListenAnimation);
    super.dispose();
  }

  void _onListenAnimation(AnimationStatus status) {
    // ignore: unrelated_type_equality_checks
    if (status == AnimationStatus.completed) {
      Size media = MediaQuery.of(context).size;
      setState(() {
        widthDevice = media.width;
        heightDevice = media.height;
        isVisibleContainer = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Stack(
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Container(
                  alignment: _aligment.value,
                  child: child,
                );
              },
              child: InkWell(
                onTap: () {
                  _controller.forward();
                },
                child: AnimatedContainer(
                  onEnd: () {
                    _controllerContainer.forward();
                    setState(() {
                      wasAnimationCompleted = !wasAnimationCompleted;
                    });
                  },
                  duration: const Duration(milliseconds: 200),
                  width: widthDevice,
                  height: heightDevice,
                  decoration: isVisibleContainer
                      ? const BoxDecoration(
                          color: Colors.orange,
                        )
                      : const BoxDecoration(
                          color: Colors.orange,
                          image: DecorationImage(
                              image: AssetImage("assets/book.jpeg"),
                              fit: BoxFit.cover)),
                  padding: const EdgeInsets.only(
                    top: 80,
                  ),
                  child: wasAnimationCompleted
                      ? FadeTransition(
                          opacity: _containerSize,
                          child: Visibility(
                            visible: isVisibleContainer,
                            child: SingleChildScrollView(
                              child: Container(
                                width: media.width,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              setState(() {
                                                isVisibleContainer = false;
                                                widthDevice = 120;
                                                heightDevice = 120;
                                              });
                                              _controller.reverse();
                                            },
                                            icon: const Icon(
                                              Icons.close,
                                              size: 30,
                                            )),
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              left: 120, top: 10),
                                          child: Text(
                                            "Chapter 01",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18),
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 40,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Text(
                                        "Design Thinking",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 38),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(
                                          left: 10, top: 30, right: 10),
                                      child: Text(
                                        "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                        textAlign: TextAlign.justify,
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(
                                          left: 10, top: 30, right: 10),
                                      child: Text(
                                        "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                        textAlign: TextAlign.justify,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Center(
                                      child: MaterialButton(
                                        minWidth: 320,
                                        height: 60,
                                        onPressed: () {},
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        color: Colors.black45,
                                        child: const Text(
                                          "Chapter 02",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
