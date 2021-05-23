import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tasq/models/org_member.dart';
import 'package:tasq/utils/constants/firebase_collections.dart';

abstract class PrefServices {
  Future<Stream<List<OrgMember>>> getAllPendingRequest();
  Future singleReq();
}

class PS implements PrefServices {
  FirebaseFirestore db = FirebaseFirestore.instance;
  @override
  Future<Stream<List<OrgMember>>> getAllPendingRequest() async {
    print("enter");

    var ref = FBCollections.orgMembers
        .where("status", isEqualTo: 0)
        .snapshots()
        .asBroadcastStream();
    var x = ref.map((event) {
      event.docs.map((e) => OrgMember.fromJson(e.data())).toList();
    });

    return x;
  }

  Future singleReq() {
    FBCollections.orgMembers.doc("please-font-change").get().then((value) {
      print("${value.data()}");
    });
  }
}
