import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/categories/categories.dart';
import '../channels_categories_cubit/channels_categories_cubit.dart';

class BlocProviders {
  static List<BlocProvider> blocs() {
    return <BlocProvider>[
      BlocProvider(
        create: (context) =>
            ChannelsCategoriesCubit(ChannelsCategoriesRepository()),
      ),
    ];
  }
}
