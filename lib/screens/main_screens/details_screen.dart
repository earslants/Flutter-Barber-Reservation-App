import 'package:flutter/material.dart';
import 'package:kuaforv1/widgets/details_text_widget.dart';

class DetailsPage extends StatelessWidget {

  const DetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detaylar"),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: const SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              DetailsTextWidget(
                title: "Merhaba",
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
              DetailsTextWidget(
                title: "Bu sayfada, uygulamanın nasıl kullanılabileceği ve bu uygulamada neler yapabileceğin hakkında bilgi edinebilirsin !\n\nBu uygulama, kuaförler ve müşterilerin rahatlıkla kullanabileceği ve rezervasyon işlemlerini kolaylıkla yapabilmeleri için tasarlandı.",
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
              DetailsTextWidget(
                title: "Müşteri Kullanımı",
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
              DetailsTextWidget(
                title: "Sisteme giriş yapıldığında, Popüler kuaförleri 'Popüler' başlığı altında görebilir, bu kuaförleri favoriye ekleyebilir ve üzerine tıklayarak bu kuaförlerden istediğiniz seansı bularak rezervasyon işleminizi gerçekleştirebilirsiniz.\n\n Sağ tarafta bulunan filtre barına, sağ altta bulunan filtre ikonuna tıklayarak erişebilir, veya ekranın sağ tarafından başlayarak parmağınızı sola kaydırarak kullanmaya başlayabilirsiniz. Daha sonra kendi isteğinize göre kuaförleri filtreleyip, dilediğiniz kuaförden rezervasyonunuzu oluşturabilirsiniz. İşte bu kadar basit !",
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
              DetailsTextWidget(
                title: "Kuaför Kullanımı",
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
              DetailsTextWidget(
                title: "Bir kuaför olarak hesap oluşturup, sisteme giriş yaptıktan sonra ekranda 4 adet buton görünecektir. İlk defa kullanıyorsanız ilk yapmanız gereken, 'Kuaför Ekle' butonunu kullanarak kendi kuaförünüzü sisteme ekleyebilirsiniz. Bu işlemden sonra, 'Seans Ekle' butonunu kullanarak, kuaförünüzün açılış, kapanış ve işlem süresi (bir saç kesim işleminin ne kadar sürede tamamlandığı) bilgilerinizi girmeniz gerekmektedir. Tüm yapmanız gereken bu ! Sistem otomatik olarak kuaförünüz için seanslar oluşturup, kullanıcıların görebileceği şekilde düzenleyecektir.\n\n Kullanıcılar artık sizin kuaförünüzden randevu alabilir. Alınan randevuları görüntülemek için 'Rezervasyonları Görüntüle' butonuna basmanız yeterli. Bu ekranda, kullanıcının telefon numarası ve rezervasyon saati bilgileri yer alacaktır.\n\n Eğer sisteme, kendiniz randevu oluşturmak istiyorsanız, 'Manuel Rezervasyon Oluşturma' başlığı altında detaylı bilgi edinebilirsiniz.",
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
              DetailsTextWidget(
                title: "Manuel Rezervasyon Oluşturma",
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
              DetailsTextWidget(
                title: "Randevu oluşturma işlemi için müşterilerin sadece bu uygulamayı kullanması gerekmiyor. Eğer bir müşteri, telefon numarası ile sizi arayıp randevu oluşturmak isterse veya kuaförünüze gelip rezervasyon talep ederse, sağ üstte bulunan '+' butonuna tıklayarak randevu oluşturabilirsiniz.\n\n Bu butona tıklandığında telefon numarası ve seans bilgisi isteyen bir ekran açılacaktır. Müşterinin telefon numarasını girip, daha sonra 'seans seç' butonuna tıklayıp, seans seçmeniz gerekmektedir. Merak etmeyin, burada sadece boş seanslar listelenmektedir. İşte yapmanız gereken bu kadar basit !",
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

