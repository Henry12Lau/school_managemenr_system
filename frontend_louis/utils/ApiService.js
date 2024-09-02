export async function CallApi(
  url,
  data,
  successCallBackFunction,
  failCallBackFunction,
) {
  try {
    await $fetch(url, {
      method: "POST",
      credentials: "include",
      body: data,
    }).then(async (response) => {
      // console.log(response);
      // if (response.status != 200) {
      //   if (failCallBackFunction != null) {
      //     failCallBackFunction();
      //   }
      // }
      if (successCallBackFunction != null) {
        successCallBackFunction(response);
      }
    });
  } catch (error) {
    if (failCallBackFunction != null) {
      failCallBackFunction();
    }
  }
}
