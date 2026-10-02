.class public Lcom/android/systemui/car/wm/scalableui/panel/controller/OrientationLayoutWatcher;
.super Ljava/lang/Object;
.source "OrientationLayoutWatcher.java"

# interfaces
.implements Landroid/hardware/display/DisplayManager$DisplayListener;
.implements Ljava/lang/Runnable;


# static fields
.field private static sStarted:Z


# instance fields
.field private final mContext:Landroid/content/Context;

.field private mApplied:Z

.field private mPortrait:Z


# direct methods
.method private constructor <init>(Landroid/content/Context;)V
    .registers 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/OrientationLayoutWatcher;->mContext:Landroid/content/Context;

    return-void
.end method

.method public static start(Landroid/content/Context;)V
    .registers 6

    if-eqz p0, :cond_return

    sget-boolean v0, Lcom/android/systemui/car/wm/scalableui/panel/controller/OrientationLayoutWatcher;->sStarted:Z

    if-eqz v0, :cond_register

    :cond_return
    return-void

    :cond_register
    const/4 v0, 0x1

    sput-boolean v0, Lcom/android/systemui/car/wm/scalableui/panel/controller/OrientationLayoutWatcher;->sStarted:Z

    new-instance v0, Lcom/android/systemui/car/wm/scalableui/panel/controller/OrientationLayoutWatcher;

    invoke-direct {v0, p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/OrientationLayoutWatcher;-><init>(Landroid/content/Context;)V

    const-class v1, Landroid/hardware/display/DisplayManager;

    invoke-virtual {p0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/hardware/display/DisplayManager;

    if-nez v1, :cond_listener

    const-string v0, "OrientationLayout"

    const-string v1, "DisplayManager missing"

    invoke-static {v0, v1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    return-void

    :cond_listener
    new-instance v2, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v3

    invoke-direct {v2, v3}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    invoke-virtual {v1, v0, v2}, Landroid/hardware/display/DisplayManager;->registerDisplayListener(Landroid/hardware/display/DisplayManager$DisplayListener;Landroid/os/Handler;)V

    const-wide/16 v3, 0x7d0

    invoke-virtual {v2, v0, v3, v4}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    return-void
.end method

.method private apply()V
    .registers 8

    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/OrientationLayoutWatcher;->mContext:Landroid/content/Context;

    const-class v1, Landroid/hardware/display/DisplayManager;

    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/hardware/display/DisplayManager;

    if-nez v0, :cond_display

    return-void

    :cond_display
    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/hardware/display/DisplayManager;->getDisplay(I)Landroid/view/Display;

    move-result-object v0

    if-nez v0, :cond_rotation

    return-void

    :cond_rotation
    invoke-virtual {v0}, Landroid/view/Display;->getRotation()I

    move-result v0

    if-eqz v0, :cond_portrait

    const/4 v1, 0x2

    if-ne v0, v1, :cond_landscape

    :cond_portrait
    const/4 v1, 0x1

    goto :cond_check

    :cond_landscape
    const/4 v1, 0x0

    :cond_check
    iget-boolean v2, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/OrientationLayoutWatcher;->mApplied:Z

    if-eqz v2, :cond_apply

    iget-boolean v2, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/OrientationLayoutWatcher;->mPortrait:Z

    if-ne v2, v1, :cond_apply

    return-void

    :cond_apply
    const/4 v2, 0x1

    iput-boolean v2, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/OrientationLayoutWatcher;->mApplied:Z

    iput-boolean v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/OrientationLayoutWatcher;->mPortrait:Z

    if-eqz v1, :cond_event_land

    const-string v1, "orientation_portrait"

    goto :cond_log

    :cond_event_land
    const-string v1, "orientation_landscape"

    :cond_log
    const-string v2, "OrientationLayout"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "rotation="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v3, " event="

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v2, v0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    invoke-direct {p0, v1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/OrientationLayoutWatcher;->dispatch(Ljava/lang/String;)V

    iget-boolean v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/OrientationLayoutWatcher;->mPortrait:Z

    invoke-static {v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->onOrientationApplied(Z)V

    return-void
.end method

.method private dispatch(Ljava/lang/String;)V
    .registers 8

    :try_start_0
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/OrientationLayoutWatcher;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    const-string v2, "getWMComponent"

    const/4 v3, 0x0

    new-array v4, v3, [Ljava/lang/Class;

    invoke-virtual {v1, v2, v4}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    new-array v2, v3, [Ljava/lang/Object;

    invoke-virtual {v1, v0, v2}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    const-string v2, "getScalableUIEventDispatcher"

    new-array v4, v3, [Ljava/lang/Class;

    invoke-virtual {v1, v2, v4}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    new-array v2, v3, [Ljava/lang/Object;

    invoke-virtual {v1, v0, v2}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    new-instance v1, Lcom/android/car/scalableui/model/Event$Builder;

    invoke-direct {v1, p1}, Lcom/android/car/scalableui/model/Event$Builder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1}, Lcom/android/car/scalableui/model/Event$Builder;->build()Lcom/android/car/scalableui/model/Event;

    move-result-object v1

    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v2

    const-string v3, "executeEvent"

    const-class v4, Lcom/android/car/scalableui/model/Event;

    filled-new-array {v4}, [Ljava/lang/Class;

    move-result-object v4

    invoke-virtual {v2, v3, v4}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v2

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-virtual {v2, v0, v1}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_done

    :catchall_0
    move-exception v0

    const-string v1, "OrientationLayout"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "EventDispatcher.executeEvent("

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ") failed"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    :try_start_1
    new-instance v0, Lcom/android/car/scalableui/model/Event$Builder;

    invoke-direct {v0, p1}, Lcom/android/car/scalableui/model/Event$Builder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Lcom/android/car/scalableui/model/Event$Builder;->build()Lcom/android/car/scalableui/model/Event;

    move-result-object v0

    invoke-static {v0}, Lcom/android/car/scalableui/manager/StateManager;->handleEvent(Lcom/android/car/scalableui/model/Event;)Lcom/android/car/scalableui/model/PanelTransaction;

    move-result-object v0

    if-eqz v0, :cond_fallback_done

    invoke-virtual {v0}, Lcom/android/car/scalableui/model/PanelTransaction;->getAnimators()Ljava/util/Set;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_anim
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_fallback_done

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/util/Map$Entry;

    invoke-interface {v2}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v3

    if-eqz v3, :goto_anim

    check-cast v3, Landroid/animation/Animator;

    invoke-virtual {v3}, Landroid/animation/Animator;->start()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    goto :goto_anim

    :cond_fallback_done
    goto :goto_done

    :catchall_1
    move-exception v0

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v2, " fallback failed"

    invoke-virtual {p1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {v1, p1, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    :goto_done
    return-void
.end method


# virtual methods
.method public onDisplayAdded(I)V
    .registers 2

    return-void
.end method

.method public onDisplayChanged(I)V
    .registers 2

    if-nez p1, :cond_skip

    invoke-direct {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/OrientationLayoutWatcher;->apply()V

    :cond_skip
    return-void
.end method

.method public onDisplayRemoved(I)V
    .registers 2

    return-void
.end method

.method public run()V
    .registers 1

    invoke-direct {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/OrientationLayoutWatcher;->apply()V

    return-void
.end method
