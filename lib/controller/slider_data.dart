import 'package:news_app/models/slider_model.dart';

List<SliderModel> getSliders() {
  List<SliderModel> slider = [];
  SliderModel categoryModel = new SliderModel();

  categoryModel.image = "assets/pexels-shoper-pl-550490863-17485352.jpg";
  categoryModel.name = "Bow To The Authority of Silenforce";
  slider.add(categoryModel);

  categoryModel = new SliderModel();
  categoryModel.image = "assets/pexels-wendywei-1190297.jpg";
  categoryModel.name = "Bow To The Authority of Silenforce";
  slider.add(categoryModel);

  categoryModel = new SliderModel();
  categoryModel.image = "assets/pexels-pixabay-40568.jpg";
  categoryModel.name = "Bow To The Authority of Silenforce";
  slider.add(categoryModel);
  categoryModel = new SliderModel();

  return slider;
}
