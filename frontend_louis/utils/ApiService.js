export async function CallApi(
  url,
  data,
  successCallBackFunction,
  failCallBackFunction,
  context,
) {
  try {
    var mySelf = this;
    await $fetch(url, {
      method: "POST",
      credentials: "include",
      body: data,
    })
      .then(async (response) => {
        if (successCallBackFunction != null) {
          successCallBackFunction(response);
        }
      })
  } catch (error) {
    switch (error.response.status) {
      case 401:
        context.$router.push("/login");
        break;
      case 403:
        context.$router.push("/");
        break;
    }
    if (failCallBackFunction != null) {
      failCallBackFunction();
    }
  }
}
