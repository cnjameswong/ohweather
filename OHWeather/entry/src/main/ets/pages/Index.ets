import axios, { AxiosError, AxiosResponse } from '@ohos/axios';

@Entry
@Component
struct Index {
  @State message: string = 'Hello World';
  @State inputCity: string = "";

  build() {
    RelativeContainer() {
      TextInput({
        placeholder:"请输入城市",
        text:"北京"
      }).id("city_input")
        .width("100%")
        .height(50)
        .margin({
          top:10
        })
        .onChange((value: string) => {
          console.info("input " + value);
          this.inputCity = value;
        })
        .onFocus(() => {
          console.info('获取焦点');
        })
        .alignRules({
          left:{anchor:"__container__", align:HorizontalAlign.Start},
          top:{anchor:"__container__", align:VerticalAlign.Top},
          right:{anchor:"__container__", align:HorizontalAlign.End}

        })

      Button("查询")
        .onClick(()=> {
          console.info("city " + this.inputCity);
          this.queryCityWeather(this.inputCity)
        })
        .alignRules({
          left:{anchor:"__container__", align:HorizontalAlign.Start},
          top:{anchor:"city_input", align:VerticalAlign.Bottom},
          right:{anchor:"__container__", align:HorizontalAlign.End}

        })
        .margin({
          top:20
        })

    }
    .height('100%')
    .width('100%')
    .padding(20)
  }

  queryCityWeather(city: string) {
    if (city) {
      // 发送一个get请求（默认请求方式）
      axios.get<string, AxiosResponse<string>, null>('http://v0.yiketianqi.com/free/v2030', {
        params: { city: "北京",
          appid:"32648328",
          appsecret:"qT4R89ik"} })
        .then((response: AxiosResponse) => {
          console.info("result:" + JSON.stringify(response.data));
        })
        .catch((error: AxiosError) => {
          console.error("result:" + error.message);
        });
    }
  }
}