.class Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$1;
.super Ljava/lang/Object;
.source "CarSysuiScalableHeaderController.java"

# interfaces
.implements Landroid/car/hardware/property/CarPropertyManager$CarPropertyEventCallback;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;


# direct methods
.method constructor <init>(Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;)V
    .registers 2

    .line 110
    iput-object p1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$1;->this$0:Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method synthetic lambda$onChangeEvent$0$com-android-systemui-car-wm-scalableui-panel-controller-CarSysuiScalableHeaderController$1(IF)V
    .registers 4

    .line 121
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$1;->this$0:Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;

    # invokes: Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->updateHvacDisplay(IF)V
    invoke-static {v0, p1, p2}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->access$400(Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;IF)V

    return-void
.end method

.method synthetic lambda$onChangeEvent$1$com-android-systemui-car-wm-scalableui-panel-controller-CarSysuiScalableHeaderController$1(II)V
    .registers 4

    .line 125
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$1;->this$0:Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;

    # invokes: Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->updateSeatDisplay(II)V
    invoke-static {v0, p1, p2}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->access$300(Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;II)V

    return-void
.end method

.method synthetic lambda$onChangeEvent$2$com-android-systemui-car-wm-scalableui-panel-controller-CarSysuiScalableHeaderController$1(I)V
    .registers 3

    .line 129
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$1;->this$0:Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;

    # invokes: Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->updateFanDirectionUi(I)V
    invoke-static {v0, p1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->access$200(Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;I)V

    return-void
.end method

.method synthetic lambda$onChangeEvent$3$com-android-systemui-car-wm-scalableui-panel-controller-CarSysuiScalableHeaderController$1(I)V
    .registers 3

    .line 134
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$1;->this$0:Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;

    # setter for: Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->mFanSpeed:I
    invoke-static {v0, p1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->access$002(Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;I)I

    .line 135
    iget-object p1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$1;->this$0:Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;

    # invokes: Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->refreshFanSpeedUi()V
    invoke-static {p1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->access$100(Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;)V

    .line 136
    return-void
.end method

.method synthetic lambda$onChangeEvent$4$com-android-systemui-car-wm-scalableui-panel-controller-CarSysuiScalableHeaderController$1(Z)V
    .registers 3

    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$1;->this$0:Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;

    invoke-virtual {v0, p1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->applyTemperatureDisplayUnit(Z)V

    return-void
.end method

.method public onChangeEvent(Landroid/car/hardware/CarPropertyValue;)V
    .registers 6

    .line 113
    if-nez p1, :cond_3

    .line 114
    return-void

    .line 116
    :cond_3
    invoke-virtual {p1}, Landroid/car/hardware/CarPropertyValue;->getAreaId()I

    move-result v0

    .line 117
    invoke-virtual {p1}, Landroid/car/hardware/CarPropertyValue;->getPropertyId()I

    move-result v1

    .line 118
    invoke-virtual {p1}, Landroid/car/hardware/CarPropertyValue;->getValue()Ljava/lang/Object;

    move-result-object p1

    .line 119
    const v2, 0x15600503

    if-ne v1, v2, :cond_units

    instance-of v2, p1, Ljava/lang/Float;

    if-eqz v2, :cond_29

    .line 120
    check-cast p1, Ljava/lang/Float;

    invoke-virtual {p1}, Ljava/lang/Float;->floatValue()F

    move-result p1

    .line 121
    iget-object v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$1;->this$0:Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;

    new-instance v2, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$1$$ExternalSyntheticLambda0;

    invoke-direct {v2, p0, v0, p1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$1$$ExternalSyntheticLambda0;-><init>(Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$1;IF)V

    invoke-virtual {v1, v2}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->runOnViewThread(Ljava/lang/Runnable;)V

    .line 122
    goto :goto_7d

    :cond_units
    const v2, 0x1140050e

    if-ne v1, v2, :cond_29

    instance-of v2, p1, Ljava/lang/Integer;

    if-eqz v2, :cond_29

    check-cast p1, Ljava/lang/Integer;

    invoke-static {p1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/HvacTemperatureUnits;->isFahrenheit(Ljava/lang/Integer;)Z

    move-result p1

    iget-object v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$1;->this$0:Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;

    new-instance v2, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$1$$ExternalSyntheticLambda4;

    invoke-direct {v2, p0, p1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$1$$ExternalSyntheticLambda4;-><init>(Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$1;Z)V

    invoke-virtual {v1, v2}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->runOnViewThread(Ljava/lang/Runnable;)V

    goto :goto_7d

    :cond_29
    const v2, 0x1540050b

    if-ne v1, v2, :cond_43

    instance-of v2, p1, Ljava/lang/Integer;

    if-eqz v2, :cond_43

    .line 124
    check-cast p1, Ljava/lang/Integer;

    invoke-virtual {p1}, Ljava/lang/Integer;->intValue()I

    move-result p1

    .line 125
    iget-object v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$1;->this$0:Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;

    new-instance v2, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$1$$ExternalSyntheticLambda1;

    invoke-direct {v2, p0, v0, p1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$1$$ExternalSyntheticLambda1;-><init>(Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$1;II)V

    invoke-virtual {v1, v2}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->runOnViewThread(Ljava/lang/Runnable;)V

    .line 126
    goto :goto_7d

    :cond_43
    const v2, 0x15400501

    const/4 v3, 0x1

    if-ne v1, v2, :cond_60

    instance-of v2, p1, Ljava/lang/Integer;

    if-eqz v2, :cond_60

    if-ne v0, v3, :cond_60

    .line 128
    check-cast p1, Ljava/lang/Integer;

    invoke-virtual {p1}, Ljava/lang/Integer;->intValue()I

    move-result p1

    .line 129
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$1;->this$0:Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;

    new-instance v1, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$1$$ExternalSyntheticLambda2;

    invoke-direct {v1, p0, p1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$1$$ExternalSyntheticLambda2;-><init>(Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$1;I)V

    invoke-virtual {v0, v1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->runOnViewThread(Ljava/lang/Runnable;)V

    goto :goto_7c

    .line 130
    :cond_60
    const v2, 0x15400500

    if-ne v1, v2, :cond_7c

    instance-of v1, p1, Ljava/lang/Integer;

    if-eqz v1, :cond_7c

    if-ne v0, v3, :cond_7c

    .line 132
    check-cast p1, Ljava/lang/Integer;

    invoke-virtual {p1}, Ljava/lang/Integer;->intValue()I

    move-result p1

    .line 133
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$1;->this$0:Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;

    new-instance v1, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$1$$ExternalSyntheticLambda3;

    invoke-direct {v1, p0, p1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$1$$ExternalSyntheticLambda3;-><init>(Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController$1;I)V

    invoke-virtual {v0, v1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->runOnViewThread(Ljava/lang/Runnable;)V

    goto :goto_7d

    .line 130
    :cond_7c
    :goto_7c
    nop

    .line 138
    :goto_7d
    return-void
.end method

.method public onErrorEvent(II)V
    .registers 5

    .line 142
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "VHAL error property="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v0, " zone="

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    const-string p2, "CarSysuiHeaderCtrl"

    invoke-static {p2, p1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 143
    return-void
.end method
