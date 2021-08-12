import 'package:bestapp_package/src/widgets/loading/shimmer-loading/shimmer.dart';
import 'package:flutter/material.dart';

class BeShimmerLoading extends StatefulWidget {
  const BeShimmerLoading({
    Key key,
    @required this.isLoading,
    @required this.child,
  }) : super(key: key);

  final bool isLoading;
  final Widget child;

  @override
  _BeShimmerLoadingState createState() => _BeShimmerLoadingState();
}

class _BeShimmerLoadingState extends State<BeShimmerLoading> {
  Listenable _shimmerChanges;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_shimmerChanges != null) {
      _shimmerChanges.removeListener(_onShimmerChange);
    }
    _shimmerChanges = BeShimmer.of(context)?.shimmerChanges;
    if (_shimmerChanges != null) {
      _shimmerChanges.addListener(_onShimmerChange);
    }
  }

  @override
  void dispose() {
    _shimmerChanges?.removeListener(_onShimmerChange);
    super.dispose();
  }

  void _onShimmerChange() {
    if (widget.isLoading) {
      setState(() {
        // update the shimmer painting.
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isLoading) {
      return widget.child;
    }

    // Collect ancestor shimmer info.
    final shimmer = BeShimmer.of(context);
    if (shimmer != null && !shimmer.isSized) {
      // The ancestor Shimmer widget has not laid
      // itself out yet. Return an empty box.
      return const SizedBox();
    }
    final shimmerSize = shimmer.size;
    final gradient = shimmer.gradient;
    final offsetWithinShimmer = shimmer.getDescendantOffset(
      descendant: context.findRenderObject() as RenderBox,
    );

    return ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (bounds) {
        return gradient.createShader(
          Rect.fromLTWH(
            -offsetWithinShimmer.dx,
            -offsetWithinShimmer.dy,
            shimmerSize.width,
            shimmerSize.height,
          ),
        );
      },
      child: widget.child,
    );
  }
}