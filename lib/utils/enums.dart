class Enums {
  static Role role = Role();
  static TaskStatus taskStatus = TaskStatus();
  static TaskApplication taskApplication = TaskApplication();
  static TaskAssign task = TaskAssign();
  static OrgRequestEnum orgRequest = OrgRequestEnum();
  static MessageTypeEnums msgType = MessageTypeEnums();
}

class Role {
  int admin = 0, user = 1;
}

class TaskStatus {
  int active = 0, assigned = 1, expired = 2;
}

class TaskApplication {
  int applied = 0, inProgress = 1, rejected = 2, completed = 3;
}

class TaskAssign {
  int notAssigned = 0, team = 1, organization = 2, everyOne = 3;
}

class OrgRequestEnum {
  int pending = 0, accepted = 1, rejected = 2;
}

class MessageTypeEnums {
  int text = 0, image = 1, video = 2;
}
