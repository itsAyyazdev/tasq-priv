import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tasq/models/org_member.dart';
import 'package:tasq/utils/constants/firebase_collections.dart';
import 'package:tasq/utils/enums.dart';
import 'package:tasq/utils/globals/app_data/app_user.dart';

abstract class PrefServices {
  // Future<Stream<List<OrgMember>>> getAllPendingRequest();
  Future<List<OrgMember>> getOrgTeam();
  Future<List<OrgMember>> getPendingRequests();
  Future<void> updateRequestStatus(String requestId, int status);
}

class PS implements PrefServices {
  FirebaseFirestore db = FirebaseFirestore.instance;
  @override
  Future<Stream<List<OrgMember>>> getAllPendingRequest() async {
    var ref = FBCollections.orgMembers
        .where("status", isEqualTo: Enums.orgRequest.pending)
        .snapshots()
        .asBroadcastStream();
    var x = ref.map((event) {
      print("event = ${event.size}");
      event.docs.map((e) => OrgMember.fromJson(e.data())).toList();
    });
    return x;
  }

  @override
  Future<void> updateRequestStatus(String requestId, int status) async {
    DocumentReference docRef = FBCollections.orgMembers.doc(requestId);
    Map<String, dynamic> payload = {
      "status": status,
      "accepted_at": Timestamp.now()
    };
    await db.runTransaction((trx) async => trx.update(docRef, payload));
  }

  @override
  Future<List<OrgMember>> getPendingRequests() async {
    Query query = FBCollections.orgMembers;
    print("\nLooking for pendings\n");
    query = query.where("status", isEqualTo: Enums.orgRequest.pending);
    query = query.where("org_id", isEqualTo: AppUser.organization.orgId);
    QuerySnapshot querySnapshot = await query.get();
    List<OrgMember> requests = [];
    querySnapshot.docs.forEach((req) {
      requests.add(OrgMember.fromJson(req.data()));
    });
    return Future.value(requests);
  }

  @override
  Future<List<OrgMember>> getOrgTeam() async {
    Query query = FBCollections.orgMembers;
    print("\nLooking for accepted\n");
    query = query.where("status", isEqualTo: Enums.orgRequest.accepted);
    query = query.where("org_id", isEqualTo: AppUser.organization.orgId);
    QuerySnapshot querySnapshot = await query.get();
    List<OrgMember> requests = [];
    querySnapshot.docs.forEach((req) {
      requests.add(OrgMember.fromJson(req.data()));
    });
    return Future.value(requests);
  }
}
