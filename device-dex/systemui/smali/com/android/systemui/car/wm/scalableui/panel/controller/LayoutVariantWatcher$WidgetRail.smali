.class final Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher$WidgetRail;
.super Landroid/view/View;
.source "LayoutVariantWatcher.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x12
    name = "WidgetRail"
.end annotation


# instance fields
.field private final mPaint:Landroid/graphics/Paint;

.field final synthetic this$0:Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;


# direct methods
.method constructor <init>(Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;Landroid/content/Context;)V
    .registers 4

    iput-object p1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher$WidgetRail;->this$0:Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;

    invoke-direct {p0, p2}, Landroid/view/View;-><init>(Landroid/content/Context;)V

    new-instance p1, Landroid/graphics/Paint;

    const/4 p2, 0x1

    invoke-direct {p1, p2}, Landroid/graphics/Paint;-><init>(I)V

    iput-object p1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher$WidgetRail;->mPaint:Landroid/graphics/Paint;

    invoke-virtual {p0, p2}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher$WidgetRail;->setClickable(Z)V

    const-string p1, "Widget pages"

    invoke-virtual {p0, p1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher$WidgetRail;->setContentDescription(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher$WidgetRail;->mPaint:Landroid/graphics/Paint;

    sget-object p2, Landroid/graphics/Paint$Cap;->ROUND:Landroid/graphics/Paint$Cap;

    invoke-virtual {p1, p2}, Landroid/graphics/Paint;->setStrokeCap(Landroid/graphics/Paint$Cap;)V

    iget-object p1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher$WidgetRail;->mPaint:Landroid/graphics/Paint;

    sget-object p2, Landroid/graphics/Paint$Join;->ROUND:Landroid/graphics/Paint$Join;

    invoke-virtual {p1, p2}, Landroid/graphics/Paint;->setStrokeJoin(Landroid/graphics/Paint$Join;)V

    return-void
.end method

.method private drawChevron(Landroid/graphics/Canvas;FFFZZ)V
    .registers 18

    invoke-virtual {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher$WidgetRail;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    iget v0, v0, Landroid/util/DisplayMetrics;->density:F

    iget-object v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher$WidgetRail;->mPaint:Landroid/graphics/Paint;

    sget-object v2, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    iget-object v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher$WidgetRail;->mPaint:Landroid/graphics/Paint;

    if-eqz p5, :cond_fill_off

    const v2, 0xf0141820

    goto :goto_fill

    :cond_fill_off
    const v2, 0x6610141c

    :goto_fill
    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setColor(I)V

    iget-object v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher$WidgetRail;->mPaint:Landroid/graphics/Paint;

    invoke-virtual {p1, p2, p3, p4, v1}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    iget-object v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher$WidgetRail;->mPaint:Landroid/graphics/Paint;

    sget-object v2, Landroid/graphics/Paint$Style;->STROKE:Landroid/graphics/Paint$Style;

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    const v1, 0x3fc00000    # 1.5f

    mul-float/2addr v1, v0

    iget-object v2, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher$WidgetRail;->mPaint:Landroid/graphics/Paint;

    invoke-virtual {v2, v1}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    iget-object v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher$WidgetRail;->mPaint:Landroid/graphics/Paint;

    if-eqz p5, :cond_ring_off

    const v2, 0x55ffffff

    goto :goto_ring

    :cond_ring_off
    const v2, 0x22ffffff

    :goto_ring
    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setColor(I)V

    iget-object v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher$WidgetRail;->mPaint:Landroid/graphics/Paint;

    invoke-virtual {p1, p2, p3, p4, v1}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    const v1, 0x40200000    # 2.5f

    mul-float/2addr v1, v0

    iget-object v2, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher$WidgetRail;->mPaint:Landroid/graphics/Paint;

    invoke-virtual {v2, v1}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    iget-object v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher$WidgetRail;->mPaint:Landroid/graphics/Paint;

    if-eqz p5, :cond_chev_off

    const/4 v2, -0x1

    goto :goto_chev

    :cond_chev_off
    const v2, 0x55ffffff

    :goto_chev
    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setColor(I)V

    const/high16 v1, 0x40c00000    # 6.0f

    mul-float/2addr v1, v0

    const/high16 v2, 0x40400000    # 3.0f

    mul-float/2addr v2, v0

    if-eqz p6, :cond_down

    sub-float v0, p3, v2

    add-float v2, p3, v2

    goto :goto_arms

    :cond_down
    add-float v0, p3, v2

    sub-float v2, p3, v2

    :goto_arms
    sub-float v3, p2, v1

    add-float v1, p2, v1

    iget-object v4, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher$WidgetRail;->mPaint:Landroid/graphics/Paint;

    move-object v5, p1

    move v6, v3

    move v7, v2

    move v8, p2

    move v9, v0

    move-object v10, v4

    invoke-virtual/range {v5 .. v10}, Landroid/graphics/Canvas;->drawLine(FFFFLandroid/graphics/Paint;)V

    move-object v5, p1

    move v6, p2

    move v7, v0

    move v8, v1

    move v9, v2

    move-object v10, v4

    invoke-virtual/range {v5 .. v10}, Landroid/graphics/Canvas;->drawLine(FFFFLandroid/graphics/Paint;)V

    return-void
.end method


# virtual methods
.method protected onDraw(Landroid/graphics/Canvas;)V
    .registers 16

    invoke-virtual {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher$WidgetRail;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    iget v0, v0, Landroid/util/DisplayMetrics;->density:F

    invoke-virtual {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher$WidgetRail;->getWidth()I

    move-result v1

    int-to-float v1, v1

    const/high16 v2, 0x40000000    # 2.0f

    div-float/2addr v1, v2

    const/high16 v2, 0x41a00000    # 20.0f

    mul-float/2addr v2, v0

    const/high16 v3, 0x40800000    # 4.0f

    mul-float/2addr v3, v0

    add-float v4, v3, v2

    invoke-virtual {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher$WidgetRail;->getHeight()I

    move-result v5

    int-to-float v5, v5

    sub-float/2addr v5, v3

    sub-float/2addr v5, v2

    iget-object v3, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher$WidgetRail;->this$0:Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;

    invoke-static {v3}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->access$500(Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;)I

    move-result v3

    if-lez v3, :cond_up_off

    const/4 v6, 0x1

    goto :goto_up

    :cond_up_off
    const/4 v6, 0x0

    :goto_up
    move-object v7, p0

    move-object v8, p1

    move v9, v1

    move v10, v4

    move v11, v2

    move v12, v6

    const/4 v13, 0x1

    invoke-direct/range {v7 .. v13}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher$WidgetRail;->drawChevron(Landroid/graphics/Canvas;FFFZZ)V

    const/4 v6, 0x3

    if-ge v3, v6, :cond_down_on

    const/4 v6, 0x0

    goto :goto_down

    :cond_down_on
    const/4 v6, 0x1

    :goto_down
    move v10, v5

    move v12, v6

    const/4 v13, 0x0

    invoke-direct/range {v7 .. v13}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher$WidgetRail;->drawChevron(Landroid/graphics/Canvas;FFFZZ)V

    const/high16 v6, 0x41600000    # 14.0f

    mul-float/2addr v6, v0

    add-float v7, v4, v2

    add-float/2addr v7, v6

    sub-float v5, v5, v2

    sub-float/2addr v5, v6

    sub-float/2addr v5, v7

    const/high16 v2, 0x40400000    # 3.0f

    div-float/2addr v5, v2

    iget-object v2, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher$WidgetRail;->mPaint:Landroid/graphics/Paint;

    sget-object v4, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {v2, v4}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    const/4 v2, 0x0

    const/4 v4, 0x0

    move-object v9, p1

    move v10, v1

    const/high16 v11, 0x0

    const/high16 v12, 0x0

    iget-object v13, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher$WidgetRail;->mPaint:Landroid/graphics/Paint;

    :goto_dots
    const/4 v4, 0x4

    if-ge v2, v4, :cond_done

    iget-object v8, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher$WidgetRail;->mPaint:Landroid/graphics/Paint;

    if-ne v2, v3, :cond_dot_off

    const/4 v6, -0x1

    goto :goto_dot

    :cond_dot_off
    const v6, 0x66ffffff

    :goto_dot
    invoke-virtual {v8, v6}, Landroid/graphics/Paint;->setColor(I)V

    int-to-float v11, v2

    mul-float/2addr v11, v5

    add-float/2addr v11, v7

    if-ne v2, v3, :cond_r_off

    const/high16 v6, 0x40a00000    # 5.0f

    goto :goto_r

    :cond_r_off
    const v6, 0x40600000    # 3.5f

    :goto_r
    mul-float/2addr v6, v0

    iget-object v13, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher$WidgetRail;->mPaint:Landroid/graphics/Paint;

    move-object v9, p1

    move v10, v1

    move v12, v6

    invoke-virtual/range {v9 .. v13}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    add-int/lit8 v2, v2, 0x1

    goto :goto_dots

    :cond_done
    return-void
.end method

.method public onTouchEvent(Landroid/view/MotionEvent;)Z
    .registers 12

    const/4 v0, 0x1

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getActionMasked()I

    move-result v1

    if-eq v1, v0, :cond_up

    return v0

    :cond_up
    invoke-virtual {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher$WidgetRail;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v1

    iget v1, v1, Landroid/util/DisplayMetrics;->density:F

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getY()F

    move-result v2

    const/high16 v3, 0x41a00000    # 20.0f

    mul-float/2addr v3, v1

    const/high16 v4, 0x40800000    # 4.0f

    mul-float/2addr v4, v1

    add-float v5, v4, v3

    invoke-virtual {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher$WidgetRail;->getHeight()I

    move-result v6

    int-to-float v6, v6

    sub-float/2addr v6, v4

    sub-float/2addr v6, v3

    const/high16 v4, 0x40c00000    # 6.0f

    mul-float/2addr v4, v1

    add-float/2addr v4, v3

    sub-float v7, v2, v5

    invoke-static {v7}, Ljava/lang/Math;->abs(F)F

    move-result v7

    cmpg-float v7, v7, v4

    if-gtz v7, :cond_not_up

    iget-object v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher$WidgetRail;->this$0:Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;

    const/4 v2, -0x1

    invoke-static {v1, v2}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->access$900(Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;I)V

    return v0

    :cond_not_up
    sub-float v7, v2, v6

    invoke-static {v7}, Ljava/lang/Math;->abs(F)F

    move-result v7

    cmpg-float v7, v7, v4

    if-gtz v7, :cond_dots

    iget-object v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher$WidgetRail;->this$0:Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;

    invoke-static {v1, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->access$900(Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;I)V

    return v0

    :cond_dots
    const/high16 v4, 0x41600000    # 14.0f

    mul-float/2addr v4, v1

    add-float/2addr v5, v3

    add-float/2addr v5, v4

    sub-float/2addr v6, v3

    sub-float/2addr v6, v4

    sub-float/2addr v6, v5

    const/high16 v1, 0x40400000    # 3.0f

    div-float/2addr v6, v1

    sub-float/2addr v2, v5

    div-float/2addr v2, v6

    invoke-static {v2}, Ljava/lang/Math;->round(F)I

    move-result v1

    if-ltz v1, :cond_out_low

    const/4 v3, 0x4

    if-ge v1, v3, :cond_out_high

    iget-object v2, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher$WidgetRail;->this$0:Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;

    invoke-static {v2}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->access$500(Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;)I

    move-result v2

    sub-int/2addr v1, v2

    iget-object v2, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher$WidgetRail;->this$0:Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;

    invoke-static {v2, v1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;->access$900(Lcom/android/systemui/car/wm/scalableui/panel/controller/LayoutVariantWatcher;I)V

    return v0

    :cond_out_low
    return v0

    :cond_out_high
    return v0
.end method
