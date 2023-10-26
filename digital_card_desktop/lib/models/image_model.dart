class Image {
  int imageID;
  String path;
  String? originalName;
  String? uniqueName;
  String? creationDate;
  bool? isActive;

  Image(this.imageID, this.path, this.originalName, this.uniqueName,
      this.creationDate, this.isActive);

  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(json["ImageID"], json["Path"], json["OriginalName"],
        json["UniqueName"], json["CreationDate"], json["IsActive"]);
  }
}
