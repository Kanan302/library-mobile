part of 'get_categories_cubit.dart';

abstract class GetCategoriesState extends Equatable {
  const GetCategoriesState();

  @override
  List<Object?> get props => [];
}

class GetCategoriesInitial extends GetCategoriesState {}

class GetCategoriesLoading extends GetCategoriesState {}

class GetCategoriesSuccess extends GetCategoriesState {
  final List<GetCategoryEntity> response;

  const GetCategoriesSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class GetCategoriesError extends GetCategoriesState {
  final String errorMessage;

  const GetCategoriesError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
