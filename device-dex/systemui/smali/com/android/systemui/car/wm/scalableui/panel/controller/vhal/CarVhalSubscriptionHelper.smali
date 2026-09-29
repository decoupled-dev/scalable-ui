.class public final Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;
.super Ljava/lang/Object;
.source "CarVhalSubscriptionHelper.java"


# instance fields
.field public final mCallbacks:Landroid/util/SparseArray;

.field public mCar:Landroid/car/Car;

.field public final mCarLifecycleListener:Landroid/car/Car$CarServiceLifecycleListener;

.field public mCarPropertyManager:Landroid/car/hardware/property/CarPropertyManager;

.field public mConnected:Z

.field public final mConnectionListeners:Ljava/util/List;

.field public mLifecycleActive:Z

.field public final mMainHandler:Landroid/os/Handler;


# direct methods
.method public static synthetic $r8$lambda$ZW6HLPN9nQNejS-T6LE9xjZFi90(Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;Landroid/car/Car;Z)V
    .registers 3

    .line 0
    invoke-virtual {p0, p1, p2}, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->lambda$new$0(Landroid/car/Car;Z)V

    return-void
.end method

.method public constructor <init>()V
    .registers 3

    .line 35
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 44
    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    iput-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mMainHandler:Landroid/os/Handler;

    .line 45
    new-instance v0, Landroid/util/SparseArray;

    invoke-direct {v0}, Landroid/util/SparseArray;-><init>()V

    iput-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mCallbacks:Landroid/util/SparseArray;

    .line 47
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mConnectionListeners:Ljava/util/List;

    .line 54
    new-instance v0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper$$ExternalSyntheticLambda0;

    invoke-direct {v0, p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper$$ExternalSyntheticLambda0;-><init>(Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;)V

    iput-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mCarLifecycleListener:Landroid/car/Car$CarServiceLifecycleListener;

    return-void
.end method


# virtual methods
.method public addConnectionListener(Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper$VhalConnectionListener;)V
    .registers 3

    .line 102
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mConnectionListeners:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 103
    iget-boolean p0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mConnected:Z

    if-eqz p0, :cond_c

    .line 104
    invoke-interface {p1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper$VhalConnectionListener;->onVhalConnected()V

    :cond_c
    return-void
.end method

.method public getFloatProperty(II)Ljava/lang/Float;
    .registers 6

    .line 153
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mCarPropertyManager:Landroid/car/hardware/property/CarPropertyManager;

    const/4 v1, 0x0

    if-nez v0, :cond_6

    return-object v1

    .line 157
    :cond_6
    :try_start_6
    invoke-virtual {v0, p1, p2}, Landroid/car/hardware/property/CarPropertyManager;->getFloatProperty(II)F

    move-result p2

    invoke-static {p2}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object p0
    :try_end_e
    .catch Landroid/car/CarNotConnectedException; {:try_start_6 .. :try_end_e} :catch_f

    return-object p0

    :catch_f
    move-exception p2

    .line 159
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v2, "CarNotConnectedException reading "

    invoke-direct {v0, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    const-string v0, "CarVhalSubscription"

    invoke-static {v0, p1, p2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 160
    invoke-virtual {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->notifyDisconnected()V

    return-object v1
.end method

.method public getIntProperty(II)Ljava/lang/Integer;
    .registers 6

    .line 180
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mCarPropertyManager:Landroid/car/hardware/property/CarPropertyManager;

    const/4 v1, 0x0

    if-nez v0, :cond_6

    return-object v1

    .line 184
    :cond_6
    :try_start_6
    invoke-virtual {v0, p1, p2}, Landroid/car/hardware/property/CarPropertyManager;->getIntProperty(II)I

    move-result p2

    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p0
    :try_end_e
    .catch Landroid/car/CarNotConnectedException; {:try_start_6 .. :try_end_e} :catch_f

    return-object p0

    :catch_f
    move-exception p2

    .line 186
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v2, "CarNotConnectedException reading "

    invoke-direct {v0, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    const-string v0, "CarVhalSubscription"

    invoke-static {v0, p1, p2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 187
    invoke-virtual {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->notifyDisconnected()V

    return-object v1
.end method

.method public final synthetic lambda$new$0(Landroid/car/Car;Z)V
    .registers 4

    .line 55
    iget-boolean v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mLifecycleActive:Z

    if-nez v0, :cond_5

    return-void

    :cond_5
    if-eqz p2, :cond_b

    .line 59
    invoke-virtual {p0, p1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->onCarReady(Landroid/car/Car;)V

    return-void

    .line 61
    :cond_b
    invoke-virtual {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->onCarDisconnected()V

    return-void
.end method

.method public final notifyConnected()V
    .registers 2

    .line 245
    iget-object p0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mConnectionListeners:Ljava/util/List;

    invoke-interface {p0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p0

    :goto_6
    invoke-interface {p0}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_16

    invoke-interface {p0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper$VhalConnectionListener;

    .line 246
    invoke-interface {v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper$VhalConnectionListener;->onVhalConnected()V

    goto :goto_6

    :cond_16
    return-void
.end method

.method public final notifyDisconnected()V
    .registers 2

    .line 251
    iget-object p0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mConnectionListeners:Ljava/util/List;

    invoke-interface {p0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p0

    :goto_6
    invoke-interface {p0}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_16

    invoke-interface {p0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper$VhalConnectionListener;

    .line 252
    invoke-interface {v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper$VhalConnectionListener;->onVhalDisconnected()V

    goto :goto_6

    :cond_16
    return-void
.end method

.method public final onCarDisconnected()V
    .registers 2

    const/4 v0, 0x0

    .line 222
    iput-boolean v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mConnected:Z

    const/4 v0, 0x0

    .line 223
    iput-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mCarPropertyManager:Landroid/car/hardware/property/CarPropertyManager;

    .line 224
    invoke-virtual {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->notifyDisconnected()V

    return-void
.end method

.method public final onCarReady(Landroid/car/Car;)V
    .registers 4

    .line 208
    :try_start_0
    const-string v0, "property"

    invoke-virtual {p1, v0}, Landroid/car/Car;->getCarManager(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Landroid/car/hardware/property/CarPropertyManager;

    iput-object p1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mCarPropertyManager:Landroid/car/hardware/property/CarPropertyManager;

    if-eqz p1, :cond_15

    const/4 p1, 0x1

    .line 210
    iput-boolean p1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mConnected:Z

    .line 211
    invoke-virtual {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->notifyConnected()V

    return-void

    :catch_13
    move-exception p1

    goto :goto_19

    .line 213
    :cond_15
    invoke-virtual {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->notifyDisconnected()V
    :try_end_18
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_18} :catch_13

    return-void

    .line 216
    :goto_19
    const-string v0, "CarVhalSubscription"

    const-string v1, "Failed to obtain CarPropertyManager"

    invoke-static {v0, v1, p1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 217
    invoke-virtual {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->notifyDisconnected()V

    return-void
.end method

.method public removeConnectionListener(Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper$VhalConnectionListener;)V
    .registers 2

    .line 109
    iget-object p0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mConnectionListeners:Ljava/util/List;

    invoke-interface {p0, p1}, Ljava/util/List;->remove(Ljava/lang/Object;)Z

    return-void
.end method

.method public setFloatProperty(IIF)Z
    .registers 6

    .line 166
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mCarPropertyManager:Landroid/car/hardware/property/CarPropertyManager;

    const/4 v1, 0x0

    if-nez v0, :cond_6

    return v1

    .line 170
    :cond_6
    :try_start_6
    invoke-virtual {v0, p1, p2, p3}, Landroid/car/hardware/property/CarPropertyManager;->setFloatProperty(IIF)V
    :try_end_9
    .catch Landroid/car/CarNotConnectedException; {:try_start_6 .. :try_end_9} :catch_b
    .catch Ljava/lang/Exception; {:try_start_6 .. :try_end_9} :catch_range

    const/4 p0, 0x1

    return p0

    :catch_range
    move-exception p2

    const-string p1, "CarVhalSubscription"

    const-string p3, "Rejected float write"

    invoke-static {p1, p3, p2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    return v1

    :catch_b
    move-exception p2

    .line 173
    new-instance p3, Ljava/lang/StringBuilder;

    const-string v0, "CarNotConnectedException writing "

    invoke-direct {p3, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p3, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {p3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    const-string p3, "CarVhalSubscription"

    invoke-static {p3, p1, p2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 174
    invoke-virtual {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->notifyDisconnected()V

    return v1
.end method

.method public setIntProperty(III)Z
    .registers 6

    .line 193
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mCarPropertyManager:Landroid/car/hardware/property/CarPropertyManager;

    const/4 v1, 0x0

    if-nez v0, :cond_6

    return v1

    .line 197
    :cond_6
    :try_start_6
    invoke-virtual {v0, p1, p2, p3}, Landroid/car/hardware/property/CarPropertyManager;->setIntProperty(III)V
    :try_end_9
    .catch Landroid/car/CarNotConnectedException; {:try_start_6 .. :try_end_9} :catch_b

    const/4 p0, 0x1

    return p0

    :catch_b
    move-exception p2

    .line 200
    new-instance p3, Ljava/lang/StringBuilder;

    const-string v0, "CarNotConnectedException writing "

    invoke-direct {p3, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p3, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {p3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    const-string p3, "CarVhalSubscription"

    invoke-static {p3, p1, p2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 201
    invoke-virtual {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->notifyDisconnected()V

    return v1
.end method

.method public start(Landroid/content/Context;)V
    .registers 6

    .line 66
    iget-boolean v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mLifecycleActive:Z

    if-eqz v0, :cond_5

    goto :goto_24

    :cond_5
    const/4 v0, 0x1

    .line 69
    iput-boolean v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mLifecycleActive:Z

    .line 71
    :try_start_8
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mMainHandler:Landroid/os/Handler;

    iget-object v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mCarLifecycleListener:Landroid/car/Car$CarServiceLifecycleListener;

    const-wide/16 v2, 0x0

    invoke-static {p1, v0, v2, v3, v1}, Landroid/car/Car;->createCar(Landroid/content/Context;Landroid/os/Handler;JLandroid/car/Car$CarServiceLifecycleListener;)Landroid/car/Car;

    move-result-object p1

    iput-object p1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mCar:Landroid/car/Car;

    if-eqz p1, :cond_24

    .line 73
    invoke-virtual {p1}, Landroid/car/Car;->isConnected()Z

    move-result p1

    if-eqz p1, :cond_24

    .line 74
    iget-object p1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mCar:Landroid/car/Car;

    invoke-virtual {p0, p1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->onCarReady(Landroid/car/Car;)V
    :try_end_21
    .catch Ljava/lang/Exception; {:try_start_8 .. :try_end_21} :catch_22

    return-void

    :catch_22
    move-exception p1

    goto :goto_25

    :cond_24
    :goto_24
    return-void

    .line 77
    :goto_25
    const-string v0, "CarVhalSubscription"

    const-string v1, "Failed to create Car connection"

    invoke-static {v0, v1, p1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 78
    invoke-virtual {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->notifyDisconnected()V

    return-void
.end method

.method public stop()V
    .registers 6

    const/4 v0, 0x0

    .line 83
    iput-boolean v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mLifecycleActive:Z

    .line 84
    invoke-virtual {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->unregisterAll()V

    .line 85
    iget-object v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mCar:Landroid/car/Car;

    const/4 v2, 0x0

    if-eqz v1, :cond_19

    .line 87
    :try_start_b
    invoke-virtual {v1}, Landroid/car/Car;->disconnect()V
    :try_end_e
    .catch Ljava/lang/Exception; {:try_start_b .. :try_end_e} :catch_f

    goto :goto_17

    :catch_f
    move-exception v1

    .line 89
    const-string v3, "CarVhalSubscription"

    const-string v4, "Error disconnecting Car"

    invoke-static {v3, v4, v1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 91
    :goto_17
    iput-object v2, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mCar:Landroid/car/Car;

    .line 93
    :cond_19
    iput-object v2, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mCarPropertyManager:Landroid/car/hardware/property/CarPropertyManager;

    .line 94
    iput-boolean v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mConnected:Z

    return-void
.end method

.method public subscribe(IILandroid/car/hardware/property/CarPropertyManager$CarPropertyEventCallback;)Z
    .registers 7

    .line 118
    iget-object p2, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mCarPropertyManager:Landroid/car/hardware/property/CarPropertyManager;

    const/4 v0, 0x0

    const-string v1, "CarVhalSubscription"

    if-nez p2, :cond_19

    .line 119
    new-instance p0, Ljava/lang/StringBuilder;

    const-string p2, "subscribe: CarPropertyManager unavailable for property "

    invoke-direct {p0, p2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {v1, p0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    return v0

    .line 123
    :cond_19
    :try_start_19
    iget-object p2, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mCallbacks:Landroid/util/SparseArray;

    invoke-virtual {p2, p1, p3}, Landroid/util/SparseArray;->put(ILjava/lang/Object;)V

    .line 124
    iget-object p2, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mCarPropertyManager:Landroid/car/hardware/property/CarPropertyManager;

    const/4 v2, 0x0

    invoke-virtual {p2, p3, p1, v2}, Landroid/car/hardware/property/CarPropertyManager;->registerCallback(Landroid/car/hardware/property/CarPropertyManager$CarPropertyEventCallback;IF)Z
    :try_end_24
    .catch Landroid/car/CarNotConnectedException; {:try_start_19 .. :try_end_24} :catch_28
    .catch Ljava/lang/IllegalArgumentException; {:try_start_19 .. :try_end_24} :catch_26

    const/4 p0, 0x1

    return p0

    :catch_26
    move-exception p0

    goto :goto_2a

    :catch_28
    move-exception p2

    goto :goto_3c

    .line 132
    :goto_2a
    new-instance p2, Ljava/lang/StringBuilder;

    const-string p3, "Property not available: "

    invoke-direct {p2, p3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {v1, p1, p0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    return v0

    .line 128
    :goto_3c
    new-instance p3, Ljava/lang/StringBuilder;

    const-string v2, "CarNotConnectedException subscribing to "

    invoke-direct {p3, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p3, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {p3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {v1, p1, p2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 129
    invoke-virtual {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->notifyDisconnected()V

    return v0
.end method

.method public final unregisterAll()V
    .registers 6

    .line 228
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mCarPropertyManager:Landroid/car/hardware/property/CarPropertyManager;

    if-nez v0, :cond_a

    .line 229
    iget-object p0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mCallbacks:Landroid/util/SparseArray;

    invoke-virtual {p0}, Landroid/util/SparseArray;->clear()V

    return-void

    :cond_a
    const/4 v0, 0x0

    .line 232
    :goto_b
    iget-object v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mCallbacks:Landroid/util/SparseArray;

    invoke-virtual {v1}, Landroid/util/SparseArray;->size()I

    move-result v1

    .line 241
    iget-object v2, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mCallbacks:Landroid/util/SparseArray;

    if-ge v0, v1, :cond_3e

    .line 233
    invoke-virtual {v2, v0}, Landroid/util/SparseArray;->keyAt(I)I

    move-result v1

    .line 234
    iget-object v2, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mCallbacks:Landroid/util/SparseArray;

    invoke-virtual {v2, v0}, Landroid/util/SparseArray;->valueAt(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/car/hardware/property/CarPropertyManager$CarPropertyEventCallback;

    .line 236
    :try_start_21
    iget-object v3, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mCarPropertyManager:Landroid/car/hardware/property/CarPropertyManager;

    invoke-virtual {v3, v2, v1}, Landroid/car/hardware/property/CarPropertyManager;->unregisterCallback(Landroid/car/hardware/property/CarPropertyManager$CarPropertyEventCallback;I)V
    :try_end_26
    .catch Landroid/car/CarNotConnectedException; {:try_start_21 .. :try_end_26} :catch_27

    goto :goto_3b

    :catch_27
    move-exception v2

    .line 238
    new-instance v3, Ljava/lang/StringBuilder;

    const-string v4, "Unregister failed for "

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const-string v3, "CarVhalSubscription"

    invoke-static {v3, v1, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    :goto_3b
    add-int/lit8 v0, v0, 0x1

    goto :goto_b

    .line 241
    :cond_3e
    invoke-virtual {v2}, Landroid/util/SparseArray;->clear()V

    return-void
.end method

.method public unsubscribe(I)V
    .registers 5

    .line 138
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mCarPropertyManager:Landroid/car/hardware/property/CarPropertyManager;

    if-nez v0, :cond_5

    goto :goto_2e

    .line 141
    :cond_5
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mCallbacks:Landroid/util/SparseArray;

    invoke-virtual {v0, p1}, Landroid/util/SparseArray;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/car/hardware/property/CarPropertyManager$CarPropertyEventCallback;

    if-eqz v0, :cond_2e

    .line 144
    :try_start_f
    iget-object v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mCarPropertyManager:Landroid/car/hardware/property/CarPropertyManager;

    invoke-virtual {v1, v0, p1}, Landroid/car/hardware/property/CarPropertyManager;->unregisterCallback(Landroid/car/hardware/property/CarPropertyManager$CarPropertyEventCallback;I)V
    :try_end_14
    .catch Landroid/car/CarNotConnectedException; {:try_start_f .. :try_end_14} :catch_15

    goto :goto_29

    :catch_15
    move-exception v0

    .line 146
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "CarNotConnectedException unsubscribing "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const-string v2, "CarVhalSubscription"

    invoke-static {v2, v1, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 148
    :goto_29
    iget-object p0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/vhal/CarVhalSubscriptionHelper;->mCallbacks:Landroid/util/SparseArray;

    invoke-virtual {p0, p1}, Landroid/util/SparseArray;->remove(I)V

    :cond_2e
    :goto_2e
    return-void
.end method
