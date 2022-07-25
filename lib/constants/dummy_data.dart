import 'package:alfa_application/constants/enums.dart';
import 'package:alfa_application/data/model/collection_model.dart';
import 'package:alfa_application/widgets/product_cell.dart';

import '../data/model/product_model.dart';

String kDummyParagraph =
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin aliquam eget magna id auctor. Donec in ligula hendrerit, molestie dolor a, tincidunt nisi. Vestibulum fermentum mauris et ligula pellentesque sagittis. Aliquam faucibus diam ut magna dapibus iaculis. Nam a ornare nulla. In et mi ipsum. Sed luctus nec lorem sit amet sagittis. Pellentesque dapibus, leo vitae aliquet iaculis, tellus erat aliquam magna, a aliquet arcu est ac odio. Nullam nec ipsum eget massa euismod hendrerit iaculis vel felis. Sed maximus cursus elit nec molestie. Duis hendrerit finibus leo. Nam vitae elit metus. Etiam rutrum urna tortor, sit amet faucibus nulla sollicitudin vitae. Donec libero nibh, feugiat ac facilisis sit amet, laoreet in nulla. Donec lobortis varius fringilla.Integer vitae posuere libero, vitae ultricies risus. Quisque sit amet placerat mauris. Nam a erat tortor. Suspendisse posuere vehicula ex vel tempus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Nam tristique nunc vel nisl tincidunt molestie. Sed rhoncus feugiat ipsum, eget scelerisque dui consectetur a.Nunc pellentesque purus a tellus sodales aliquam. Fusce fermentum a dolor eget bibendum. Integer rhoncus rhoncus ipsum, quis hendrerit sapien commodo sit amet. Duis semper fermentum accumsan. Mauris ac vulputate justo. Praesent placerat ornare fermentum. Sed vel ornare felis, nec euismod est. Aenean ac nibh tristique, tincidunt velit sed, egestas ipsum. Proin egestas massa ac risus cursus iaculis. Ut gravida elit ac orci eleifend auctor. Na in mi dictum, commodo erat quis, posuere dui. Phasellus congue ligula quis est faucibus lobortis. Suspendisse in elit vitae neque vestibulum porttitor. Pellentesque id luctus neque, efficitur consequat dui. Integer dignissim mauris id ligula rhoncus aliquamDonec tincidunt mollis ipsum. Morbi placerat volutpat maximus. Fusce ligula massa, ullamcorper eu ex at, lobortis vulputate arcu. Ut condimentum maximus lacus, quis consectetur enim. Sed id felis tortor. Maecenas auctor, tellus ut sodales ultricies, ex nisi aliquam sapien, et accumsan ante tellus id enim. Donec vel quam est. Suspendisse sem eros, facilisis blandit erat a, viverra molestie orci. Pellentesque euismod ullamcorper odio at posuere. Curabitur eu magna in ex lacinia dapibus. Vivamus pellentesque neque nec viverra venenatis. Nulla facilisi. Aliquam scelerisque ipsum ut augue vehicula tempus. Ut laoreet malesuada ligula eget rhoncus.';

ProductCell kDummyProductCell = ProductCell(
  productModel: kDummyProductModel,
);

ProductModel kDummyProductModel = ProductModel(
  productId: "",
  collectionId: "1",
  categoryId: "1",
  productTitle: "Bilezik",
  productColorType: ProductColours.Gold.toString(),
  goldPercent: ProductGoldPercents.Eighteen.toString(),
  productHeight: 12,
  productRadius: 5,
  productWeight: 15,
  productWidth: 20,
);

// AppCollectionCell kDummyCollectionCell = AppCollectionCell(
//   collection: CollectionModel(
//     collectionTitle: "Dorica",
//     collectionDescription: "Dorica gold accesserios",
//     collectionId: "1",
//     collectionImageUrl:
//         "https://st2.myideasoft.com/shop/by/23/myassets/products/110/gumus-altin-yaldizli-rodaj-ve-rose-renkli-dorissa-dorica-top-uclu-set-21502-jpg.jpeg?revision=1632200136",
//   ),
// );
