class Comment {
  constructor(comment) {
    this.id = comment.id;
    this.body = comment.body;
    this.commenter = comment.commenter;
    this.createdAt = new Date(comment.created_at);
    //Taking the created_at string and making a Date object.
  }
}