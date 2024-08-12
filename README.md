# future_provider

> [!NOTE]
>
> `FutureProvider` dose not offer a way of directly modifying the computation after a user interaction. It is designed to solve simple use-case.
>
> For more advanced scenarios, consider using `AsyncNotifierProvider`

> [!IMPORTANT]
>
> `FutureProvider`은 사용자가 `watch`만 가능하다. `read`, `listen`같은 사용자 인터렉션을 제공 하지 않는다.
>
> `ref.invaliate`, `ref.refresh` 로 다시 로딩 하는 기능을 제공한다.

- API 리퀘스트가 성공하면 state를 보존 하고 그 페이지에 다시 방문할때 캐쉬된 state를 보여줬으면 좋겠어

  => autoDispose + keepAlive()

- API 리퀘스트 성공하고 다시 리로드 했으면 좋겠어

  => API request(성공) -> 캐싱 keepAlive() 때문에 -> provider 강제 삭제 (ref.invaliate, ref.refresh) -> 리빌드

- API 리퀘스트가 실패하면 에러를 보여주고 재 방문하면 다시 리퀘스트를 했으면 좋겠어.

  API 리퀘스트 시도후 일시적인 에러 발생후 잠시후 다시 불러올 필요가 있다. 하지만 `FutureProvider`는 유저 인터렉션을 제공하지 않는다. ref.read(x), 이때 keepAlive를 사용해 유지되던 캐쉬를 삭제하면 다시 리빌드되면서 데이터를 가져오는 기능을 구현 할수 있다.

  => API request -> Error(캐싱) keepAlive() 때문에 -> provider 강제 삭제 (ref.invaliate, ref.refresh) -> Error(캐싱) 삭제 -> 재 방문시 리빌드
