import 'package:todo_list_flutter/models/models.dart';

class PostArguments {
  final List<Post> posts;
  final User user;
  final String imagePost;

  PostArguments(this.posts, this.user, this.imagePost);
}
