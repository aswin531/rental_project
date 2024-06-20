// your_project/
// │
// ├── lib/
// │   ├── core/
// │   │   ├── error/
// │   │   │   └── exceptions.dart
// │   │   │   └── failures.dart
// │   │   ├── usecases/
// │   │   │   └── usecase.dart
// │   │   ├── utils/
// │   │   │   └── input_converter.dart
// │   │   └── network/
// │   │       └── network_info.dart
// │   │       └── network_info_impl.dart
// │   │
// │   ├── features/
// │   │   ├── feature_name/
// │   │   │   ├── domain/
// │   │   │   │   ├── entities/
// │   │   │   │   │   └── example_entity.dart
// │   │   │   │   ├── repositories/
// │   │   │   │   │   └── example_repository.dart
// │   │   │   │   ├── usecases/
// │   │   │   │       └── get_example.dart
// │   │   │   │
// │   │   │   ├── data/
// │   │   │   │   ├── models/
// │   │   │   │   │   └── example_model.dart
// │   │   │   │   ├── repositories/
// │   │   │   │   │   └── example_repository_impl.dart
// │   │   │   │   ├── datasources/
// │   │   │   │       └── example_remote_data_source.dart
// │   │   │   │       └── example_local_data_source.dart
// │   │   │   │
// │   │   │   ├── presentation/
// │   │   │       ├── pages/
// │   │   │       │   └── example_page.dart
// │   │   │       ├── blocs/
// │   │   │           └── example_bloc.dart
// │   │   │           └── example_event.dart
// │   │   │           └── example_state.dart
// │   │
// │   ├── injection_container.dart
// │   └── main.dart
// │
// ├── test/
// │   ├── core/
// │   │   └── utils/
// │   │       └── input_converter_test.dart
// │   │
// │   ├── features/
// │   │   ├── feature_name/
// │   │       ├── data/
// │   │       │   └── models/
// │   │       │       └── example_model_test.dart
// │   │       │   └── repositories/
// │   │       │       └── example_repository_impl_test.dart
// │   │       │   └── datasources/
// │   │       │       └── example_remote_data_source_test.dart
// │   │       │       └── example_local_data_source_test.dart
// │   │       ├── domain/
// │   │       │   └── usecases/
// │   │       │       └── get_example_test.dart
// │   │       ├── presentation/
// │   │           └── blocs/
// │   │               └── example_bloc_test.dart
// │
// ├── .gitignore
// ├── analysis_options.yaml
// ├── pubspec.yaml
// └── README.md
