import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tasq/models/org_member.dart';
import 'package:tasq/models/organizationData.dart';
import 'package:tasq/models/user.dart';
import 'package:tasq/utils/constants/firebase_collections.dart';
import 'package:tasq/utils/globals/app_data/app_user.dart';
import 'package:tasq/utils/globals/import_hub.dart';

abstract class AuthFSServices {
  Future<UserData> getUserById(String id);
  Future<void> setUserData({String userEmail, Map payload});
  Future<void> updateUserData({String userEmail, Map payload});
  Future<Organization> getMyOrg();
  Future<List<Organization>> getAllOrganizations();
  Future<Organization> getOrganizationById(String id);
  Future<void> sendOrgJoinRequest({OrgMember member});
}

class CFS implements AuthFSServices {
  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Future<UserData> getUserById(String email) async {
    if (email == null || email.isEmpty) {
      return null;
    }
    DocumentSnapshot doc = await FBCollections.users.doc(email).get();
    if (!doc.exists) {
      return null;
    }
    UserData user = UserData.fromJson(doc.data());
    return user;
  }

  @override
  Future<void> setUserData({String userEmail, Map payload}) async {
    print("Setting user $userEmail");
    DocumentReference dr = FBCollections.users.doc(userEmail);
    try {
      db.runTransaction((t) async {
        return t.set(dr, payload);
      });
    } catch (e) {
      AppUtils.showSnackbar(msg: e.toString(), isError: true);
    }
  }

  @override
  Future<void> updateUserData({String userEmail, Map payload}) async {
    DocumentReference dr = FBCollections.users.doc(userEmail);
    try {
      db.runTransaction((t) async {
        return t.update(dr, payload);
      });
    } catch (e) {
      AppUtils.showSnackbar(msg: e.toString(), isError: true);
    }
  }

  @override
  Future<List<Organization>> getAllOrgs() async {
    Query q = FBCollections.organizations;
    QuerySnapshot qs = await q.get();
    List<Organization> orgs = [];
    if (qs.docs.isNotEmpty) {
      qs.docs.forEach((element) {
        orgs.add(Organization.fromJson(element.data()));
      });
    }
    return orgs;
  }

  @override
  Future<Organization> getMyOrg() async {
    Query query = FBCollections.organizations
        .where("owner_id", isEqualTo: AppUser.user.email);
    QuerySnapshot querySnapshot = await query.get();
    if (querySnapshot.docs.isNotEmpty) {
      return Organization.fromJson(querySnapshot.docs.first);
    } else {
      return Organization.fromJson({});
    }
  }

  @override
  Future<List<Organization>> getAllOrganizations() async {
    Query query = FBCollections.organizations;
    QuerySnapshot qs = await query.get();
    List<Organization> orgs = [];
    qs.docs.forEach((org) {
      orgs.add(Organization.fromJson(org));
    });
    return Future.value(orgs);
  }

  @override
  Future<void> sendOrgJoinRequest({OrgMember member}) async {
    String docId = AppUtils.getFreshTimeStamp();
    DocumentReference reference = FBCollections.orgMembers.doc(docId);
    member.requestedAt = Timestamp.now();
    member.requestedId = docId;
    db.runTransaction((trx) async => trx.set(reference, member.toJson()));
  }

  @override
  Future<Organization> getOrganizationById(String id) async {
    DocumentSnapshot doc = await FBCollections.organizations.doc(id).get();
    Organization org;
    if (doc.exists) {
      org = Organization.fromJson(doc.data());
    }
    return org;
  }
}
