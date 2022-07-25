import 'package:alfa_application/constants/enums.dart';
import 'package:get/get.dart';

class Languages extends Translations {
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
        'ar_SA': {
          "Company Email": "عنوان البريد الإلكتروني للشركة",
          "Company Name": "اسم الشركة",
          "Company Country": "بلد الشركة",
          "Company City": "مدينة الشركة",
          "Actions": "المعاملات التي تم إجراؤها",
          "Categories": "الفئة",
          'AccountInfo': 'معلومات الحساب',
          'OrderStatus': 'حالة الطلب',
          'OrderStatusChangedTo': ' تم تحديث حالة الطلب: ',
          'by': 'بواسطة ',
          'total': 'المجموع:',
          'products': 'منتجات:',
          'weight': 'ثقل',
          'productCode': "كود المنتج",
          'cancelled': "تم إلغاؤه",
          'cancelOrder': "الغاء الطلب",
          "Save changes": "احفظ التغييرات",
          "Are you sure to cancel this order?":
              "هل أنت متأكد أنك تريد إلغاء هذا الطلب؟",
          'no': "لا",
          'yes': 'أجل',
          "signIn": "تسجيل الدخول",
          "signSentence": "قم بتسجيل الدخول باستخدام بريدك الإلكتروني وكلمة ",
          "password": "كلمه السر",
          'email': 'البريد الإلكتروني',
          "forgotPassword": "هل نسيت كلمة السر",
          "rememberMe": "تذكرنى",
          "Home": "الصفحة الرئيسية",
          "Favorites": "المفضلة",
          "Orders": "طلب",
          "My Orders": "طلب",
          "System": "نظام",
          "Profile": "حساب تعريفي",
          "Cart": "عربة التسوق",
          "Collections": "المجموعات",
          "See All": "اظهار الكل",
          "Hi": "مرحبا",
          "Log out": "تسجيل خروج",
          "Complete Transaction": "صفقة كاملة",
          "Language Preferences": "تفضيلات اللغة",
          "Notifications": "إشعارات",
          "View": "فحص",
          "Send Email": "ارسل بريد الكتروني",
          "Order Progress": "تقدم الطلب",
          "Reset Password": "إعادة تعيين كلمة المرور",
          "Product Detail": "تفاصيل المنتج",
          "Write your email":
              "اكتب عنوان بريدك الإلكتروني للحصول\n على رابط إعادة تعيين كلمة المرور",
          "height": "ارتفاع",
          "width": "عرض",
          "radius": "نصف القطر",
          "Company Address": "عنوان الشركة",
          "Mobile Phone Number": "رقم الهاتف الجوال",
          "Phone Number": "رقم الهاتف",
          TransactionStatuses.WaitToConfirm.toString(): 'انتظر للتأكيد',
          TransactionStatuses.Confirmed.toString(): 'مؤكد',
          TransactionStatuses.WaitForPurchase.toString(): 'انتظر الشراء',
          TransactionStatuses.StartToPrepare.toString(): 'ابدأ في التحضير',
          TransactionStatuses.Send.toString(): 'يرسل',
          TransactionStatuses.Completed.toString(): 'مكتمل',
          TransactionStatuses.Cancelled.toString(): 'ألغيت',
          TransactionStatuses.NotConfirmed.toString(): 'غير مؤكد',
        },
        'tr_TR': {
          "Save changes": "Kaydet",
          "Phone Number": "Telefon numarası",
          "Mobile Phone Number": "Cep telefonu numarası",
          "Company Email": "Şirket email adresi",
          "Company Name": "Şirket adı",
          "Company Country": "Şirketin bulunduğu ülke",
          "Company City": "Şirketin bulunduğu il",
          "Company Address": "Şirket adresi",
          "height": "Boy",
          "width": "En",
          "radius": "Çap",
          "Send Email": "Email Gönder",
          "Write your email":
              "Şifre sıfırlama linkini almak için\nlütfen email adresinizi giriniz.",
          "Reset Password": "Şifre Sıfırlama",
          "Order Progress": "Sipariş Durumu",
          "View": "İncele",
          "Notifications": "Bildirimler",
          "Complete Transaction": "Siparişi Tamamla",
          "Language Preferences": "Dil Tercihleri",
          "Log out": "Çıkış yap",
          "See All": "Hepsini Gör",
          "Collections": "Koleksiyonlar",
          "Cart": "Sepet",
          "Favorites": "Favorilerim",
          "Profile": "Profil",
          "Orders": "Siparişler",
          "My Orders": "Siparişlerim",
          "Home": "Ana Sayfa",
          "System": "Sistem",
          "Categories": "Kategoriler",
          "forgotPassword": "Şifremi unuttum",
          "password": "Şifre",
          "signSentence":
              "Devam etmek için lütfen\n email adresiniz ve şifrenizi giriniz.",
          "signIn": "Giriş Yap",
          "Actions": "İşlemler",
          'AccountInfo': 'Hesap Bilgileri',
          'OrderStatus': 'Sipariş Durumu',
          'OrderStatusChangedTo': 'Sipariş durumu güncellendi: ',
          'by': 'tarafından: ',
          'products': 'Ürünler:',
          'total': "Toplam:",
          'no': "Hayır",
          'yes': 'Evet',
          'productCode': "Ürün Kodu",
          'weight': 'Ağırlık',
          'cancelled': "İptal Edildi",
          "rememberMe": "Beni hatırla",
          'cancelOrder': "Siparişi iptal et",
          'email': 'Email',
          "Hi": "Merhaba",
          "Product Detail": "Ürün Detay",
          "Are you sure to cancel this order?":
              'Bu siparişi iptal etmek istediğinize emin misiniz?',
          TransactionStatuses.WaitToConfirm.toString(): 'Sipariş Onay Bekliyor',
          TransactionStatuses.Confirmed.toString(): 'Sipariş Onaylandı',
          TransactionStatuses.WaitForPurchase.toString(): 'Ödeme Bekleniyor',
          TransactionStatuses.StartToPrepare.toString(): 'Sipariş Hazırlanıyor',
          TransactionStatuses.Send.toString(): 'Sipariş Gönderildi',
          TransactionStatuses.Completed.toString(): 'Sipariş Teslim\nEdildi',
          TransactionStatuses.Cancelled.toString(): 'Sipariş İptal\nEdildi',
          TransactionStatuses.NotConfirmed.toString(): 'Sipariş\nOnaylanmadı',
        },
        'en_US': {
          "Save changes": "Save changes",
          "Company Email": "Company email address",
          "Company Name": "Company name",
          "Company Country": "Company country",
          "Company City": "Company city",
          "Company Address": "Company address",
          "Phone Number": "Phone Number",
          "Mobile Phone Number": "Mobile Phone Number",
          "height": "Height",
          "width": "Width",
          "radius": "Radius",
          "Product Detail": "Product Detail",
          "Order Progress": "Order Progress",
          "Write your email":
              "Write your email address to get reset password link.",
          "View": "View",
          "Send Email": "Send Email",
          "Reset Password": "Reset Password",
          "Notifications": "Notifications",
          "Complete Transaction": "Complete Transaction",
          "Language Preferences": "Language Preferences",
          "Log out": "Log out",
          "Hi": "Hi",
          "Colections": "Collections",
          "See All": "See All",
          "Cart": "Cart",
          "Home": "Home",
          "Categories": "Categories",
          "Orders": "Orders",
          "My Orders": "My Orders",
          "System": "System",
          "forgotPassword": "Forgot password",
          "Favorites": "Favorites",
          "Profile": "Profile",
          "rememberMe": "Remember me",
          'email': 'Email',
          "password": "Password",
          "signIn": "Sign In",
          "signSentence": "Sign in with your email and password\nto continue",
          "Actions": "Actions",
          'AccountInfo': 'Account Information',
          'OrderStatus': 'Order Status',
          'OrderStatusChangedTo': 'Order status changed to ',
          'products': 'Products:',
          'by': 'by ',
          'no': 'No',
          'yes': 'Yes',
          'total': 'Total:',
          'weight': 'Weight',
          'productCode': "Product Code",
          'cancelled': "Cancelled",
          'cancelOrder': "Cancel Order",
          "Are you sure to cancel this order?":
              "Are you sure to cancel this order?",
          TransactionStatuses.WaitToConfirm.toString(): 'Wait For Confirm',
          TransactionStatuses.Confirmed.toString(): 'Confirmed',
          TransactionStatuses.WaitForPurchase.toString(): 'Wait For Purchase',
          TransactionStatuses.StartToPrepare.toString(): 'Start To Preape',
          TransactionStatuses.Send.toString(): 'Send',
          TransactionStatuses.Completed.toString(): 'Completed',
          TransactionStatuses.Cancelled.toString(): 'Cancelled',
          TransactionStatuses.NotConfirmed.toString(): 'Not Confirmed',
        },
      };
}