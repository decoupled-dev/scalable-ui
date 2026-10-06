.class Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher$1;
.super Ljava/lang/Object;
.source "LayoutVariantWatcher.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;


# direct methods
.method constructor <init>(Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;)V
    .registers 2

    .line 123
    iput-object p1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher$1;->this$0:Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .registers 7

    .line 126
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher$1;->this$0:Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;

    # getter for: Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mWidgetRail:Landroid/view/View;
    invoke-static {v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->access$000(Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;)Landroid/view/View;

    move-result-object v0

    if-nez v0, :cond_9

    .line 127
    return-void

    .line 129
    :cond_9
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher$1;->this$0:Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;

    # getter for: Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mContext:Landroid/content/Context;
    invoke-static {v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->access$100(Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;)Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->getVariant(Landroid/content/Context;)I

    move-result v0

    const/4 v1, 0x2

    const/4 v2, 0x0

    if-ne v0, v1, :cond_25

    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher$1;->this$0:Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;

    .line 130
    # getter for: Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mContext:Landroid/content/Context;
    invoke-static {v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->access$100(Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;)Landroid/content/Context;

    move-result-object v0

    # invokes: Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->isPortrait(Landroid/content/Context;)Z
    invoke-static {v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->access$200(Landroid/content/Context;)Z

    move-result v0

    if-nez v0, :cond_25

    const/4 v0, 0x1

    goto :goto_26

    :cond_25
    move v0, v2

    .line 131
    :goto_26
    iget-object v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher$1;->this$0:Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;

    # invokes: Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->widgetColumnCovered()Z
    invoke-static {v1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->access$300(Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;)Z

    move-result v1

    .line 132
    if-eqz v0, :cond_56

    iget-object v3, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher$1;->this$0:Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;

    # getter for: Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mColumnWasCovered:Z
    invoke-static {v3}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->access$400(Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;)Z

    move-result v3

    if-eqz v3, :cond_56

    if-nez v1, :cond_56

    .line 133
    iget-object v3, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher$1;->this$0:Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "widget_page_"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-object v5, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher$1;->this$0:Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;

    # getter for: Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mWidgetPage:I
    invoke-static {v5}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->access$500(Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;)I

    move-result v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    # invokes: Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->dispatch(Ljava/lang/String;)V
    invoke-static {v3, v4}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->access$600(Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;Ljava/lang/String;)V

    .line 135
    :cond_56
    iget-object v3, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher$1;->this$0:Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;

    # setter for: Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mColumnWasCovered:Z
    invoke-static {v3, v1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->access$402(Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;Z)Z

    .line 136
    iget-object v3, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher$1;->this$0:Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;

    # getter for: Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mWidgetRail:Landroid/view/View;
    invoke-static {v3}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->access$000(Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;)Landroid/view/View;

    move-result-object v3

    if-eqz v0, :cond_66

    if-nez v1, :cond_66

    goto :goto_68

    :cond_66
    const/16 v2, 0x8

    :goto_68
    invoke-virtual {v3, v2}, Landroid/view/View;->setVisibility(I)V

    .line 137
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher$1;->this$0:Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;

    # getter for: Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->mHandler:Landroid/os/Handler;
    invoke-static {v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->access$700(Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;)Landroid/os/Handler;

    move-result-object v0

    const-wide/16 v1, 0x190

    invoke-virtual {v0, p0, v1, v2}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    .line 138
    return-void
.end method
