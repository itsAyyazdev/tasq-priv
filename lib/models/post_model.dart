class PostModel {
  String postName,
      description,
      category,
      dueDate,
      assignTo,
      rewardOffer,
      rewardOfferId,
      companyName,
      companyId,
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
      this.companyName,
      this.companyId,
      this.points,
      this.createdAt});
}
