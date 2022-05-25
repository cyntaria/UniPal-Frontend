import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

// Models
import '../models/post_resource_model.codegen.dart';

// Widgets
import '../../shared/widgets/custom_network_image.dart';

class PostResourcesSlider extends StatelessWidget {
  const PostResourcesSlider({
    super.key,
    required this.resources,
  });

  final List<PostResourceModel> resources;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: resources.length,
      options: CarouselOptions(
        height: 250,
        enableInfiniteScroll: false,
        enlargeCenterPage: true,
      ),
      itemBuilder: (_, i, __) => CustomNetworkImage(
        imageUrl: resources[i].resourceUrl,
      ),
    );
  }
}
