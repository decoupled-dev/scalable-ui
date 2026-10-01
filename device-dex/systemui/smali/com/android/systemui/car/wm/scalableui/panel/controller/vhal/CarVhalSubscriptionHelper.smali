.class public final Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;
.super Ljava/lang/Object;
.source "CarVhalSubscriptionHelper.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper$VhalConnectionListener;
    }
.end annotation


# static fields
.field private static final TAG:Ljava/lang/String; = "CarVhalSubscription"


# instance fields
.field private final mCallbacks:Landroid/util/SparseArray;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/util/SparseArray<",
            "Landroid/car/hardware/property/CarPropertyManager$CarPropertyEventCallback;",
            ">;"
        }
    .end annotation
.end field

.field private mCar:Landroid/car/Car;

.field private final mCarLifecycleListener:Landroid/car/Car$CarServiceLifecycleListener;

.field private mCarPropertyManager:Landroid/car/hardware/property/CarPropertyManager;

.field private mConnected:Z

.field private final mConnectionListeners:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper$VhalConnectionListener;",
            ">;"
        }
    .end annotation
.end field

.field private mLifecycleActive:Z

.field private final mMainHandler:Landroid/os/Handler;


# direct methods
.method public constructor <init>()V
    .registers 3

    .line 36
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 45
    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    iput-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mMainHandler:Landroid/os/Handler;

    .line 46
    new-instance v0, Landroid/util/SparseArray;

    invoke-direct {v0}, Landroid/util/SparseArray;-><init>()V

    iput-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mCallbacks:Landroid/util/SparseArray;

    .line 48
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mConnectionListeners:Ljava/util/List;

    .line 55
    new-instance v0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper$$ExternalSyntheticLambda0;

    invoke-direct {v0, p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper$$ExternalSyntheticLambda0;-><init>(Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;)V

    iput-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mCarLifecycleListener:Landroid/car/Car$CarServiceLifecycleListener;

    return-void
.end method

.method private clampFloat(IIF)F
    .registers 5

    .line 277
    invoke-virtual {p0, p1, p2}, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->getFloatRange(II)[F

    move-result-object p1

    .line 278
    if-nez p1, :cond_7

    .line 279
    return p3

    .line 281
    :cond_7
    const/4 p2, 0x0

    aget p2, p1, p2

    const/4 v0, 0x1

    aget p1, p1, v0

    invoke-static {p1, p3}, Ljava/lang/Math;->min(FF)F

    move-result p1

    invoke-static {p2, p1}, Ljava/lang/Math;->max(FF)F

    move-result p1

    return p1
.end method

.method private clampInt(III)I
    .registers 6

    .line 286
    :try_start_0
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mCarPropertyManager:Landroid/car/hardware/property/CarPropertyManager;

    invoke-virtual {v0, p1}, Landroid/car/hardware/property/CarPropertyManager;->getCarPropertyConfig(I)Landroid/car/hardware/CarPropertyConfig;

    move-result-object v0

    .line 287
    if-nez v0, :cond_9

    .line 288
    return p3

    .line 290
    :cond_9
    invoke-virtual {v0, p2}, Landroid/car/hardware/CarPropertyConfig;->getMinValue(I)Ljava/lang/Object;

    move-result-object v1

    .line 291
    invoke-virtual {v0, p2}, Landroid/car/hardware/CarPropertyConfig;->getMaxValue(I)Ljava/lang/Object;

    move-result-object p2

    .line 292
    instance-of v0, v1, Ljava/lang/Number;

    if-eqz v0, :cond_1f

    .line 293
    check-cast v1, Ljava/lang/Number;

    invoke-virtual {v1}, Ljava/lang/Number;->intValue()I

    move-result v0

    invoke-static {v0, p3}, Ljava/lang/Math;->max(II)I

    move-result p3

    .line 295
    :cond_1f
    instance-of v0, p2, Ljava/lang/Number;

    if-eqz v0, :cond_2d

    .line 296
    check-cast p2, Ljava/lang/Number;

    invoke-virtual {p2}, Ljava/lang/Number;->intValue()I

    move-result p2

    invoke-static {p2, p3}, Ljava/lang/Math;->min(II)I

    move-result p3
    :try_end_2d
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_2d} :catch_2e

    .line 300
    :cond_2d
    goto :goto_47

    .line 298
    :catch_2e
    move-exception p2

    .line 299
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "clampInt failed prop="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    const-string v0, "CarVhalSubscription"

    invoke-static {v0, p1, p2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 301
    :goto_47
    return p3
.end method

.method private notifyConnected()V
    .registers 3

    .line 344
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mConnectionListeners:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_6
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_16

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper$VhalConnectionListener;

    .line 345
    invoke-interface {v1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper$VhalConnectionListener;->onVhalConnected()V

    .line 346
    goto :goto_6

    .line 347
    :cond_16
    return-void
.end method

.method private notifyDisconnected()V
    .registers 3

    .line 350
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mConnectionListeners:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_6
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_16

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper$VhalConnectionListener;

    .line 351
    invoke-interface {v1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper$VhalConnectionListener;->onVhalDisconnected()V

    .line 352
    goto :goto_6

    .line 353
    :cond_16
    return-void
.end method

.method private onCarDisconnected()V
    .registers 2

    .line 320
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mConnected:Z

    .line 321
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mCarPropertyManager:Landroid/car/hardware/property/CarPropertyManager;

    .line 322
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mCallbacks:Landroid/util/SparseArray;

    invoke-virtual {v0}, Landroid/util/SparseArray;->clear()V

    .line 323
    invoke-direct {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->notifyDisconnected()V

    .line 324
    return-void
.end method

.method private onCarReady(Landroid/car/Car;)V
    .registers 4

    .line 306
    :try_start_0
    const-string v0, "property"

    invoke-virtual {p1, v0}, Landroid/car/Car;->getCarManager(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Landroid/car/hardware/property/CarPropertyManager;

    iput-object p1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mCarPropertyManager:Landroid/car/hardware/property/CarPropertyManager;

    .line 307
    iget-object p1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mCarPropertyManager:Landroid/car/hardware/property/CarPropertyManager;

    if-eqz p1, :cond_15

    .line 308
    const/4 p1, 0x1

    iput-boolean p1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mConnected:Z

    .line 309
    invoke-direct {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->notifyConnected()V

    goto :goto_18

    .line 311
    :cond_15
    invoke-direct {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->notifyDisconnected()V
    :try_end_18
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_18} :catch_19

    .line 316
    :goto_18
    goto :goto_24

    .line 313
    :catch_19
    move-exception p1

    .line 314
    const-string v0, "CarVhalSubscription"

    const-string v1, "Failed to obtain CarPropertyManager"

    invoke-static {v0, v1, p1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 315
    invoke-direct {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->notifyDisconnected()V

    .line 317
    :goto_24
    return-void
.end method

.method private unregisterAll()V
    .registers 6

    .line 327
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mCarPropertyManager:Landroid/car/hardware/property/CarPropertyManager;

    if-nez v0, :cond_a

    .line 328
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mCallbacks:Landroid/util/SparseArray;

    invoke-virtual {v0}, Landroid/util/SparseArray;->clear()V

    .line 329
    return-void

    .line 331
    :cond_a
    const/4 v0, 0x0

    :goto_b
    iget-object v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mCallbacks:Landroid/util/SparseArray;

    invoke-virtual {v1}, Landroid/util/SparseArray;->size()I

    move-result v1

    if-ge v0, v1, :cond_43

    .line 332
    iget-object v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mCallbacks:Landroid/util/SparseArray;

    invoke-virtual {v1, v0}, Landroid/util/SparseArray;->keyAt(I)I

    move-result v1

    .line 333
    iget-object v2, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mCallbacks:Landroid/util/SparseArray;

    invoke-virtual {v2, v0}, Landroid/util/SparseArray;->valueAt(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/car/hardware/property/CarPropertyManager$CarPropertyEventCallback;

    .line 335
    :try_start_21
    iget-object v3, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mCarPropertyManager:Landroid/car/hardware/property/CarPropertyManager;

    invoke-virtual {v3, v2, v1}, Landroid/car/hardware/property/CarPropertyManager;->unregisterCallback(Landroid/car/hardware/property/CarPropertyManager$CarPropertyEventCallback;I)V
    :try_end_26
    .catch Landroid/car/CarNotConnectedException; {:try_start_21 .. :try_end_26} :catch_27

    .line 338
    goto :goto_40

    .line 336
    :catch_27
    move-exception v2

    .line 337
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Unregister failed for "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const-string v3, "CarVhalSubscription"

    invoke-static {v3, v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 331
    :goto_40
    add-int/lit8 v0, v0, 0x1

    goto :goto_b

    .line 340
    :cond_43
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mCallbacks:Landroid/util/SparseArray;

    invoke-virtual {v0}, Landroid/util/SparseArray;->clear()V

    .line 341
    return-void
.end method


# virtual methods
.method public addConnectionListener(Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper$VhalConnectionListener;)V
    .registers 3

    .line 103
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mConnectionListeners:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 104
    iget-boolean v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mConnected:Z

    if-eqz v0, :cond_c

    .line 105
    invoke-interface {p1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper$VhalConnectionListener;->onVhalConnected()V

    .line 107
    :cond_c
    return-void
.end method

.method public getFloatProperty(II)Ljava/lang/Float;
    .registers 7

    .line 169
    const-string v0, "CarVhalSubscription"

    iget-object v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mCarPropertyManager:Landroid/car/hardware/property/CarPropertyManager;

    const/4 v2, 0x0

    if-nez v1, :cond_8

    .line 170
    return-object v2

    .line 173
    :cond_8
    :try_start_8
    iget-object v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mCarPropertyManager:Landroid/car/hardware/property/CarPropertyManager;

    invoke-virtual {v1, p1, p2}, Landroid/car/hardware/property/CarPropertyManager;->getFloatProperty(II)F

    move-result p2

    invoke-static {p2}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object p1
    :try_end_12
    .catch Landroid/car/CarNotConnectedException; {:try_start_8 .. :try_end_12} :catch_43
    .catch Ljava/lang/SecurityException; {:try_start_8 .. :try_end_12} :catch_2b
    .catch Ljava/lang/Exception; {:try_start_8 .. :try_end_12} :catch_13

    return-object p1

    .line 181
    :catch_13
    move-exception p2

    .line 182
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Failed reading float property "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {v0, p1, p2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 183
    return-object v2

    .line 178
    :catch_2b
    move-exception p2

    .line 179
    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "No permission to read property "

    invoke-virtual {p2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {v0, p1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 180
    return-object v2

    .line 174
    :catch_43
    move-exception p2

    .line 175
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "CarNotConnectedException reading "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {v0, p1, p2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 176
    invoke-direct {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->notifyDisconnected()V

    .line 177
    return-object v2
.end method

.method public getFloatRange(II)[F
    .registers 8

    .line 250
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mCarPropertyManager:Landroid/car/hardware/property/CarPropertyManager;

    const/4 v1, 0x0

    if-nez v0, :cond_6

    .line 251
    return-object v1

    .line 254
    :cond_6
    :try_start_6
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mCarPropertyManager:Landroid/car/hardware/property/CarPropertyManager;

    invoke-virtual {v0, p1}, Landroid/car/hardware/property/CarPropertyManager;->getCarPropertyConfig(I)Landroid/car/hardware/CarPropertyConfig;

    move-result-object v0

    .line 255
    if-nez v0, :cond_f

    .line 256
    return-object v1

    .line 258
    :cond_f
    invoke-virtual {v0, p2}, Landroid/car/hardware/CarPropertyConfig;->getMinValue(I)Ljava/lang/Object;

    move-result-object v2

    .line 259
    invoke-virtual {v0, p2}, Landroid/car/hardware/CarPropertyConfig;->getMaxValue(I)Ljava/lang/Object;

    move-result-object v0

    .line 260
    instance-of v3, v2, Ljava/lang/Number;

    if-eqz v3, :cond_3b

    instance-of v3, v0, Ljava/lang/Number;

    if-nez v3, :cond_20

    goto :goto_3b

    .line 263
    :cond_20
    check-cast v2, Ljava/lang/Number;

    invoke-virtual {v2}, Ljava/lang/Number;->floatValue()F

    move-result v2

    .line 264
    check-cast v0, Ljava/lang/Number;

    invoke-virtual {v0}, Ljava/lang/Number;->floatValue()F

    move-result v0

    .line 265
    cmpg-float v3, v0, v2

    if-gez v3, :cond_31

    .line 266
    return-object v1

    .line 268
    :cond_31
    const/4 v3, 0x2

    new-array v3, v3, [F

    const/4 v4, 0x0

    aput v2, v3, v4

    const/4 v2, 0x1

    aput v0, v3, v2
    :try_end_3a
    .catch Ljava/lang/Exception; {:try_start_6 .. :try_end_3a} :catch_3c

    return-object v3

    .line 261
    :cond_3b
    :goto_3b
    return-object v1

    .line 269
    :catch_3c
    move-exception v0

    .line 270
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "getFloatRange failed prop="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v2, " area="

    invoke-virtual {p1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    const-string p2, "CarVhalSubscription"

    invoke-static {p2, p1, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 271
    return-object v1
.end method

.method public getIntProperty(II)Ljava/lang/Integer;
    .registers 6

    .line 211
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mCarPropertyManager:Landroid/car/hardware/property/CarPropertyManager;

    const/4 v1, 0x0

    if-nez v0, :cond_6

    .line 212
    return-object v1

    .line 215
    :cond_6
    :try_start_6
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mCarPropertyManager:Landroid/car/hardware/property/CarPropertyManager;

    invoke-virtual {v0, p1, p2}, Landroid/car/hardware/property/CarPropertyManager;->getIntProperty(II)I

    move-result p2

    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p1
    :try_end_10
    .catch Landroid/car/CarNotConnectedException; {:try_start_6 .. :try_end_10} :catch_11

    return-object p1

    .line 216
    :catch_11
    move-exception p2

    .line 217
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "CarNotConnectedException reading "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    const-string v0, "CarVhalSubscription"

    invoke-static {v0, p1, p2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 218
    invoke-direct {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->notifyDisconnected()V

    .line 219
    return-object v1
.end method

.method public isConnected()Z
    .registers 2

    .line 99
    iget-boolean v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mConnected:Z

    if-eqz v0, :cond_a

    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mCarPropertyManager:Landroid/car/hardware/property/CarPropertyManager;

    if-eqz v0, :cond_a

    const/4 v0, 0x1

    goto :goto_b

    :cond_a
    const/4 v0, 0x0

    :goto_b
    return v0
.end method

.method synthetic lambda$new$0$com-android-systemui-car-wm-scalableui-panel-controller-vhal-CarVhalSubscriptionHelper(Landroid/car/Car;Z)V
    .registers 4

    .line 56
    iget-boolean v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mLifecycleActive:Z

    if-nez v0, :cond_5

    .line 57
    return-void

    .line 59
    :cond_5
    if-eqz p2, :cond_b

    .line 60
    invoke-direct {p0, p1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->onCarReady(Landroid/car/Car;)V

    goto :goto_e

    .line 62
    :cond_b
    invoke-direct {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->onCarDisconnected()V

    .line 64
    :goto_e
    return-void
.end method

.method public removeConnectionListener(Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper$VhalConnectionListener;)V
    .registers 3

    .line 110
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mConnectionListeners:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->remove(Ljava/lang/Object;)Z

    .line 111
    return-void
.end method

.method public setFloatProperty(IIF)Z
    .registers 10

    .line 188
    const-string v0, " area="

    const-string v1, "CarVhalSubscription"

    iget-object v2, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mCarPropertyManager:Landroid/car/hardware/property/CarPropertyManager;

    const/4 v3, 0x0

    if-nez v2, :cond_a

    .line 189
    return v3

    .line 192
    :cond_a
    :try_start_a
    invoke-direct {p0, p1, p2, p3}, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->clampFloat(IIF)F

    move-result v2

    .line 193
    iget-object v4, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mCarPropertyManager:Landroid/car/hardware/property/CarPropertyManager;

    invoke-virtual {v4, p1, p2, v2}, Landroid/car/hardware/property/CarPropertyManager;->setFloatProperty(IIF)V
    :try_end_13
    .catch Landroid/car/CarNotConnectedException; {:try_start_a .. :try_end_13} :catch_6d
    .catch Ljava/lang/IllegalArgumentException; {:try_start_a .. :try_end_13} :catch_35
    .catch Ljava/lang/Exception; {:try_start_a .. :try_end_13} :catch_15

    .line 194
    const/4 p1, 0x1

    return p1

    .line 204
    :catch_15
    move-exception p3

    .line 205
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Failed float write prop="

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {v1, p1, p3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 206
    return v3

    .line 199
    :catch_35
    move-exception v2

    .line 201
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Rejected float write prop="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string p2, " value="

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, p3}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string p2, ": "

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    .line 202
    invoke-virtual {v2}, Ljava/lang/IllegalArgumentException;->getMessage()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    .line 201
    invoke-static {v1, p1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 203
    return v3

    .line 195
    :catch_6d
    move-exception p2

    .line 196
    new-instance p3, Ljava/lang/StringBuilder;

    invoke-direct {p3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, "CarNotConnectedException writing "

    invoke-virtual {p3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p3

    invoke-virtual {p3, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {v1, p1, p2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 197
    invoke-direct {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->notifyDisconnected()V

    .line 198
    return v3
.end method

.method public setIntProperty(III)Z
    .registers 10

    .line 224
    const-string v0, " area="

    const-string v1, "CarVhalSubscription"

    iget-object v2, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mCarPropertyManager:Landroid/car/hardware/property/CarPropertyManager;

    const/4 v3, 0x0

    if-nez v2, :cond_a

    .line 225
    return v3

    .line 228
    :cond_a
    :try_start_a
    invoke-direct {p0, p1, p2, p3}, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->clampInt(III)I

    move-result v2

    .line 229
    iget-object v4, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mCarPropertyManager:Landroid/car/hardware/property/CarPropertyManager;

    invoke-virtual {v4, p1, p2, v2}, Landroid/car/hardware/property/CarPropertyManager;->setIntProperty(III)V
    :try_end_13
    .catch Landroid/car/CarNotConnectedException; {:try_start_a .. :try_end_13} :catch_6d
    .catch Ljava/lang/IllegalArgumentException; {:try_start_a .. :try_end_13} :catch_35
    .catch Ljava/lang/Exception; {:try_start_a .. :try_end_13} :catch_15

    .line 230
    const/4 p1, 0x1

    return p1

    .line 239
    :catch_15
    move-exception p3

    .line 240
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Failed int write prop="

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {v1, p1, p3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 241
    return v3

    .line 235
    :catch_35
    move-exception v2

    .line 236
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Rejected int write prop="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string p2, " value="

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string p2, ": "

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    .line 237
    invoke-virtual {v2}, Ljava/lang/IllegalArgumentException;->getMessage()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    .line 236
    invoke-static {v1, p1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 238
    return v3

    .line 231
    :catch_6d
    move-exception p2

    .line 232
    new-instance p3, Ljava/lang/StringBuilder;

    invoke-direct {p3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, "CarNotConnectedException writing "

    invoke-virtual {p3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p3

    invoke-virtual {p3, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {v1, p1, p2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 233
    invoke-direct {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->notifyDisconnected()V

    .line 234
    return v3
.end method

.method public start(Landroid/content/Context;)V
    .registers 6

    .line 67
    iget-boolean v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mLifecycleActive:Z

    if-eqz v0, :cond_5

    .line 68
    return-void

    .line 70
    :cond_5
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mLifecycleActive:Z

    .line 72
    :try_start_8
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mMainHandler:Landroid/os/Handler;

    iget-object v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mCarLifecycleListener:Landroid/car/Car$CarServiceLifecycleListener;

    const-wide/16 v2, 0x0

    invoke-static {p1, v0, v2, v3, v1}, Landroid/car/Car;->createCar(Landroid/content/Context;Landroid/os/Handler;JLandroid/car/Car$CarServiceLifecycleListener;)Landroid/car/Car;

    move-result-object p1

    iput-object p1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mCar:Landroid/car/Car;

    .line 74
    iget-object p1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mCar:Landroid/car/Car;

    if-eqz p1, :cond_25

    iget-object p1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mCar:Landroid/car/Car;

    invoke-virtual {p1}, Landroid/car/Car;->isConnected()Z

    move-result p1

    if-eqz p1, :cond_25

    .line 75
    iget-object p1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mCar:Landroid/car/Car;

    invoke-direct {p0, p1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->onCarReady(Landroid/car/Car;)V
    :try_end_25
    .catch Ljava/lang/Exception; {:try_start_8 .. :try_end_25} :catch_26

    .line 80
    :cond_25
    goto :goto_31

    .line 77
    :catch_26
    move-exception p1

    .line 78
    const-string v0, "CarVhalSubscription"

    const-string v1, "Failed to create Car connection"

    invoke-static {v0, v1, p1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 79
    invoke-direct {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->notifyDisconnected()V

    .line 81
    :goto_31
    return-void
.end method

.method public stop()V
    .registers 6

    .line 84
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mLifecycleActive:Z

    .line 85
    invoke-direct {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->unregisterAll()V

    .line 86
    iget-object v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mCar:Landroid/car/Car;

    const/4 v2, 0x0

    if-eqz v1, :cond_1b

    .line 88
    :try_start_b
    iget-object v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mCar:Landroid/car/Car;

    invoke-virtual {v1}, Landroid/car/Car;->disconnect()V
    :try_end_10
    .catch Ljava/lang/Exception; {:try_start_b .. :try_end_10} :catch_11

    .line 91
    goto :goto_19

    .line 89
    :catch_11
    move-exception v1

    .line 90
    const-string v3, "CarVhalSubscription"

    const-string v4, "Error disconnecting Car"

    invoke-static {v3, v4, v1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 92
    :goto_19
    iput-object v2, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mCar:Landroid/car/Car;

    .line 94
    :cond_1b
    iput-object v2, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mCarPropertyManager:Landroid/car/hardware/property/CarPropertyManager;

    .line 95
    iput-boolean v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mConnected:Z

    .line 96
    return-void
.end method

.method public subscribe(IILandroid/car/hardware/property/CarPropertyManager$CarPropertyEventCallback;)Z
    .registers 8

    .line 119
    iget-object p2, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mCarPropertyManager:Landroid/car/hardware/property/CarPropertyManager;

    const/4 v0, 0x0

    const-string v1, "CarVhalSubscription"

    if-nez p2, :cond_1e

    .line 120
    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    const-string p3, "subscribe: CarPropertyManager unavailable for property "

    invoke-virtual {p2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {v1, p1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 121
    return v0

    .line 124
    :cond_1e
    iget-object p2, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mCallbacks:Landroid/util/SparseArray;

    invoke-virtual {p2, p1}, Landroid/util/SparseArray;->get(I)Ljava/lang/Object;

    move-result-object p2

    const/4 v2, 0x1

    if-ne p2, p3, :cond_28

    .line 125
    return v2

    .line 127
    :cond_28
    iget-object p2, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mCallbacks:Landroid/util/SparseArray;

    invoke-virtual {p2, p1}, Landroid/util/SparseArray;->get(I)Ljava/lang/Object;

    move-result-object p2

    if-eqz p2, :cond_33

    .line 128
    invoke-virtual {p0, p1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->unsubscribe(I)V

    .line 131
    :cond_33
    :try_start_33
    iget-object p2, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mCallbacks:Landroid/util/SparseArray;

    invoke-virtual {p2, p1, p3}, Landroid/util/SparseArray;->put(ILjava/lang/Object;)V

    .line 132
    iget-object p2, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mCarPropertyManager:Landroid/car/hardware/property/CarPropertyManager;

    const/4 v3, 0x0

    invoke-virtual {p2, p3, p1, v3}, Landroid/car/hardware/property/CarPropertyManager;->registerCallback(Landroid/car/hardware/property/CarPropertyManager$CarPropertyEventCallback;IF)Z
    :try_end_3e
    .catch Landroid/car/CarNotConnectedException; {:try_start_33 .. :try_end_3e} :catch_91
    .catch Ljava/lang/IllegalArgumentException; {:try_start_33 .. :try_end_3e} :catch_79
    .catch Ljava/lang/SecurityException; {:try_start_33 .. :try_end_3e} :catch_5c
    .catch Ljava/lang/Exception; {:try_start_33 .. :try_end_3e} :catch_3f

    .line 134
    return v2

    .line 146
    :catch_3f
    move-exception p2

    .line 147
    new-instance p3, Ljava/lang/StringBuilder;

    invoke-direct {p3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "subscribe failed for property "

    invoke-virtual {p3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p3

    invoke-virtual {p3, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p3

    invoke-virtual {p3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p3

    invoke-static {v1, p3, p2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 148
    iget-object p2, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mCallbacks:Landroid/util/SparseArray;

    invoke-virtual {p2, p1}, Landroid/util/SparseArray;->remove(I)V

    .line 149
    return v0

    .line 142
    :catch_5c
    move-exception p2

    .line 143
    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    const-string p3, "No permission to subscribe property "

    invoke-virtual {p2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-static {v1, p2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 144
    iget-object p2, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mCallbacks:Landroid/util/SparseArray;

    invoke-virtual {p2, p1}, Landroid/util/SparseArray;->remove(I)V

    .line 145
    return v0

    .line 139
    :catch_79
    move-exception p2

    .line 140
    new-instance p3, Ljava/lang/StringBuilder;

    invoke-direct {p3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Property not available: "

    invoke-virtual {p3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p3

    invoke-virtual {p3, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {v1, p1, p2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 141
    return v0

    .line 135
    :catch_91
    move-exception p2

    .line 136
    new-instance p3, Ljava/lang/StringBuilder;

    invoke-direct {p3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "CarNotConnectedException subscribing to "

    invoke-virtual {p3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p3

    invoke-virtual {p3, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {v1, p1, p2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 137
    invoke-direct {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->notifyDisconnected()V

    .line 138
    return v0
.end method

.method public unsubscribe(I)V
    .registers 5

    .line 154
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mCarPropertyManager:Landroid/car/hardware/property/CarPropertyManager;

    if-nez v0, :cond_5

    .line 155
    return-void

    .line 157
    :cond_5
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mCallbacks:Landroid/util/SparseArray;

    invoke-virtual {v0, p1}, Landroid/util/SparseArray;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/car/hardware/property/CarPropertyManager$CarPropertyEventCallback;

    .line 158
    if-eqz v0, :cond_33

    .line 160
    :try_start_f
    iget-object v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mCarPropertyManager:Landroid/car/hardware/property/CarPropertyManager;

    invoke-virtual {v1, v0, p1}, Landroid/car/hardware/property/CarPropertyManager;->unregisterCallback(Landroid/car/hardware/property/CarPropertyManager$CarPropertyEventCallback;I)V
    :try_end_14
    .catch Landroid/car/CarNotConnectedException; {:try_start_f .. :try_end_14} :catch_15

    .line 163
    goto :goto_2e

    .line 161
    :catch_15
    move-exception v0

    .line 162
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "CarNotConnectedException unsubscribing "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const-string v2, "CarVhalSubscription"

    invoke-static {v2, v1, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 164
    :goto_2e
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mCallbacks:Landroid/util/SparseArray;

    invoke-virtual {v0, p1}, Landroid/util/SparseArray;->remove(I)V

    .line 166
    :cond_33
    return-void
.end method

.method public getHvacTemperatureScale()[F
    .registers 7

    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mCarPropertyManager:Landroid/car/hardware/property/CarPropertyManager;

    if-nez v0, :cond_none

    const/4 v0, 0x0

    return-object v0

    :cond_none
    :try_start
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mCarPropertyManager:Landroid/car/hardware/property/CarPropertyManager;

    const v1, 0x15600503

    invoke-virtual {v0, v1}, Landroid/car/hardware/property/CarPropertyManager;->getCarPropertyConfig(I)Landroid/car/hardware/CarPropertyConfig;

    move-result-object v0

    if-nez v0, :cond_cfg

    const/4 v0, 0x0

    return-object v0

    :cond_cfg
    invoke-virtual {v0}, Landroid/car/hardware/CarPropertyConfig;->getConfigArray()Ljava/util/List;

    move-result-object v0

    if-nez v0, :cond_list

    const/4 v0, 0x0

    return-object v0

    :cond_list
    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v1

    const/4 v2, 0x6

    if-ge v1, v2, :cond_short

    const/4 v0, 0x0

    return-object v0

    :cond_short
    const/4 v1, 0x4

    new-array v1, v1, [F

    const/4 v2, 0x0

    invoke-interface {v0, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/Integer;

    invoke-virtual {v3}, Ljava/lang/Integer;->intValue()I

    move-result v3

    int-to-float v3, v3

    const/high16 v4, 0x41200000    # 10.0f

    div-float/2addr v3, v4

    aput v3, v1, v2

    const/4 v2, 0x2

    invoke-interface {v0, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/Integer;

    invoke-virtual {v3}, Ljava/lang/Integer;->intValue()I

    move-result v3

    int-to-float v3, v3

    div-float/2addr v3, v4

    const/4 v5, 0x1

    aput v3, v1, v5

    const/4 v2, 0x3

    invoke-interface {v0, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/Integer;

    invoke-virtual {v3}, Ljava/lang/Integer;->intValue()I

    move-result v3

    int-to-float v3, v3

    div-float/2addr v3, v4

    const/4 v5, 0x2

    aput v3, v1, v5

    const/4 v2, 0x5

    invoke-interface {v0, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/Integer;

    invoke-virtual {v3}, Ljava/lang/Integer;->intValue()I

    move-result v3

    int-to-float v3, v3

    div-float/2addr v3, v4

    const/4 v5, 0x3

    aput v3, v1, v5

    return-object v1
    :try_end
    .catch Ljava/lang/Exception; {:try_start .. :try_end} :catch_all

    :catch_all
    const/4 v0, 0x0

    return-object v0
.end method
