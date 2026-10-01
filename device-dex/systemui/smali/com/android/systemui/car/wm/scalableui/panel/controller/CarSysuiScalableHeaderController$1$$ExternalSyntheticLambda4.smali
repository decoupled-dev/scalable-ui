.class public final synthetic Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$1$$ExternalSyntheticLambda4;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field public final synthetic f$0:Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$1;

.field public final synthetic f$1:Z


# direct methods
.method public constructor <init>(Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$1;Z)V
    .registers 3

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$1$$ExternalSyntheticLambda4;->f$0:Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$1;

    iput-boolean p2, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$1$$ExternalSyntheticLambda4;->f$1:Z

    return-void
.end method


# virtual methods
.method public final run()V
    .registers 3

    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$1$$ExternalSyntheticLambda4;->f$0:Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$1;

    iget-boolean v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$1$$ExternalSyntheticLambda4;->f$1:Z

    invoke-virtual {v0, v1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$1;->lambda$onChangeEvent$4$com-android-systemui-car-wm-scalableui-panel-controller-CarSysuiScalableHeaderController$1(Z)V

    return-void
.end method
