import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tasq/models/job.dart';
import 'package:tasq/models/todo.dart';
import 'package:tasq/utils/constants/firebase_collections.dart';
import 'package:tasq/utils/enums.dart';
import 'package:tasq/utils/globals/app_data/app_user.dart';
import 'package:tasq/utils/globals/import_hub.dart';

abstract class HomeServices {
  Future<Stream<List<Job>>> getAllActiveTasks();
  Future<List<Job>> getMyPostedTasks();
  Future<void> postTasQ({Job task});
  Future<void> addTodo({Todo todo});
  Future<void> updateTodo({String id});
  Future<void> deleteTodo({String id});

  Future<List<Todo>> getMyTodos();
}

class HS implements HomeServices {
  FirebaseFirestore db = FirebaseFirestore.instance;
  @override
  Future<Stream<List<Job>>> getAllActiveTasks() async {
    var ref = FBCollections.jobs
        .where("org_id", isEqualTo: AppUser.organization.orgId)
        .where("status", isGreaterThan: Enums.task.notAssigned)
        .snapshots()
        .asBroadcastStream();
    var x = ref
        .map((event) => event.docs.map((e) => Job.fromJson(e.data())).toList());
    return x;
  }

  @override
  Future<List<Job>> getMyPostedTasks() async {
    Query query = FBCollections.jobs
        .where("org_id", isEqualTo: AppUser.organization.orgId);
    QuerySnapshot querySnapshot = await query.get();
    List<Job> jobs = [];
    if (querySnapshot.docs.isNotEmpty) {
      querySnapshot.docs.forEach((job) {
        jobs.add(Job.fromJson(job));
      });
    }
    return Future.value(jobs);
  }

  @override
  Future<void> postTasQ({Job task}) async {
    String docId = AppUtils.getFreshTimeStamp();
    DocumentReference docRef = FBCollections.jobs.doc(docId);
    task.jobId = docId;
    await db.runTransaction((trx) async => trx.set(docRef, task.toJson()));
  }

  @override
  Future<void> addTodo({Todo todo}) async {
    String docId = AppUtils.getFreshTimeStamp();
    DocumentReference docRef = FBCollections.todos.doc(docId);
    todo.id = docId;
    todo.userId = AppUser.user.email;
    await db.runTransaction((trx) async => trx.set(docRef, todo.toJson()));
  }

  @override
  Future<List<Todo>> getMyTodos() async {
    Query query =
        FBCollections.todos.where("user_id", isEqualTo: AppUser.user.email);
    QuerySnapshot querySnapshot = await query.get();
    List<Todo> toDos = [];
    if (querySnapshot.docs.isNotEmpty) {
      querySnapshot.docs.forEach((job) {
        toDos.add(Todo.fromJson(job));
      });
    }
    return Future.value(toDos);
  }

  @override
  Future<void> deleteTodo({String id}) async {
    DocumentReference docRef = FBCollections.todos.doc(id);
    await db.runTransaction((trx) async => trx.delete(docRef));
  }

  @override
  Future<void> updateTodo({String id}) async {
    DocumentReference docRef = FBCollections.todos.doc(id);
    Map<String, bool> payload = {"is_checked": true};
    await db.runTransaction((trx) async => trx.update(docRef, payload));
  }
}
