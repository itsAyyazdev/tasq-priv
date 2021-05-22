class Enums {
  static Role role = Role();
  static TaskStatus taskStatus = TaskStatus();
  static TaskApplication taskApplication = TaskApplication();
}

class Role {
  int admin = 0, user = 1;
}

class TaskStatus {
  int active = 0, assigned = 1, expired = 2;
}

class TaskApplication {
  int applied = 0, acceptedAndAssigned = 1, rejected = 2;
}
