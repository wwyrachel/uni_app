import 'package:firebase_database/firebase_database.dart';
import 'post_models.dart';

class PostService{
  String nodeName = "posts";
  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference _databaseReference;

  Map post;

  PostService(this.post);



  addPosts(){
    _databaseReference = database.reference().child(nodeName);
    _databaseReference.push().set(post);
  }

  deletePosts(){
    database.reference().child('$nodeName/${post['key']}').remove();
  }

  updatePost(){
    database.reference().child('$nodeName/${post['key']}').update(
      {
        "title": post["title"], "body": post["body"], "date": post["date"]
      }
    );
  }
}