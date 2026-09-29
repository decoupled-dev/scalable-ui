.class public Lcom/android/systemui/car/wm/scalableui/panel/controller/NightModeToggle;
.super Ljava/lang/Object;
.source "NightModeToggle.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# instance fields
.field private final mController:Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;


# direct methods
.method public constructor <init>(Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;)V
    .registers 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/NightModeToggle;->mController:Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .registers 3

    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/NightModeToggle;->mController:Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;

    invoke-virtual {v0, p1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableHeaderController;->toggleNightMode(Landroid/view/View;)V

    return-void
.end method
