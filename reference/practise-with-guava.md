# 使用Guava提高代码效率

Guava Maven 依赖

~~~xml
<dependency>
    <groupId>com.google.guava</groupId>
    <artifactId>guava</artifactId>
    <version>17.0</version>
</dependency>
~~~

使用Guava Utilities，可以有效地减少代码数量

~~~java
# 把key中的"."替换成“_”
String key = Joiner.on('_').join(Splitter.on('.').split(key));
~~~

使用Guava Cache，对于对时效要求不高，并且获取完整信息代价高昂（可能需要访问多个远端服务），在一个用户连续访问的时候可以有效提高效率

~~~
private final LoadingCache<Long, OfferInfo> offerCache = CacheBuilder.newBuilder()
    .expireAfterWrite(EXPIRED_MINUTES, TimeUnit.MINUTES).softValues().build(new CacheLoader<Long, OfferInfo>() {
        @Override public OfferInfo load(Long offerId) throws Exception {
            //retrieve the offer info
        }
    });
~~~
