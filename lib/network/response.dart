class BaseResponse{
  final int page;
  final int per_page;
  final int total;
  final int total_pages;

  const BaseResponse(
    this.page,
    this.per_page,
    this.total,
    this.total_pages
  );
}

class UserResponse extends BaseResponse{
  final List<User> data;

  const UserResponse(
    int page,
    int per_page,
    int total,
    int total_pages,

    this.data
  ):super(page, per_page, total, total_pages);

  factory UserResponse.fromJson(Map<String, dynamic> json){
    return switch(json){
      {
        'page' : int page,
        'per_page' : int per_page,
        'total' : int total,
        'total_pages' : int total_pages,
        'data' : List datas,
      } => UserResponse(
          page, 
          per_page, 
          total, 
          total_pages, 
          datas.map((data) => User.fromJson(data)).toList()
        ),
        _ => throw const FormatException('Failed to load userResponse from json'),
      };
  }
}

class User{
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String avatar;

  const User(
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.avatar
  );

  factory User.fromJson(Map<String, dynamic> json){
    return switch(json){
      {
        'id' : int id,
        'email' : String email,
        'first_name' : String firstName,
        'last_name' : String lastName,
        'avatar' : String avatar,
      } => User(id, email, firstName, lastName, avatar),
      _ => throw const FormatException('Failed to load user from json.'),
    };
  }
}