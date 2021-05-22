class PostModel {
  String postName,
      description,
      category,
      dueDate,
      assignTo,
      rewardOffer,
      rewardOfferId,
      orgName,
      orgId,
      points;
  DateTime createdAt;

  PostModel(
      {this.postName,
      this.description,
      this.category,
      this.dueDate,
      this.assignTo,
      this.rewardOffer,
      this.rewardOfferId,
      this.orgName,
      this.orgId,
      this.points,
      this.createdAt});
}
