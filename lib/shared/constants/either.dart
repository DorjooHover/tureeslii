import 'package:dartz/dartz.dart';
import 'package:landlord/model/models.dart';

// user either
typedef EitherUser<T> = Future<Either<String, User>>;
typedef EitherUsers<T> = Future<Either<String, List<User>>>;

// cancelation
typedef EitherCancelations<T> = Future<Either<String, List<Cancelation>>>;
// config
typedef EitherConfig<T> = Future<Either<String, Config>>;
// category
typedef EitherCategory<T> = Future<Either<String, Category>>;
typedef EitherCategories<T> = Future<Either<String, List<Category>>>;
// post
typedef EitherPost<T> = Future<Either<String, Post>>;
typedef EitherPosts<T> = Future<Either<String, List<Post>>>;

// verification 
typedef EitherVerification<T> = Future<Either<String, Verification>>;

// rentRequest
typedef EitherRentRequest<T> = Future<Either<String, RentRequest>>;
typedef EitherRentRequests<T> = Future<Either<String, List<RentRequest>>>;
// notifications
typedef EitherNotification<T> = Future<Either<String, Notifications>>;
typedef EitherNotifications<T> = Future<Either<String, List<Notifications>>>;


// any
typedef EitherText<T> = Future<Either<String, String>>;
typedef EitherHandler<T> = Future<Either<String, ErrorHandler>>;

typedef EitherMap<T> = Future<Either<String, Map<String, List>>>;
typedef EitherSuccess<T> = Future<Either<String, bool>>;
typedef EitherMessage<T> = Future<Either<String, String>>;