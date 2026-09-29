.class public Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;
.super Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableBarControllerBase;
.source "CarSysuiScalableFooterController.java"


# instance fields
.field public mActiveController:Landroid/media/session/MediaController;

.field public mFooterUxScrim:Landroid/view/View;

.field public mFullscreenToggle:Landroid/widget/ImageButton;

.field public mIsPlaying:Z

.field public final mMediaCallback:Landroid/media/session/MediaController$Callback;

.field public mMediaNext:Landroid/widget/ImageButton;

.field public final mMediaPanelId:Ljava/lang/String;

.field public mMediaPanelVisible:Z

.field public mMediaPlayPause:Landroid/widget/ImageButton;

.field public mMediaPrev:Landroid/widget/ImageButton;

.field public mMediaRoot:Landroid/view/View;

.field public mMediaSessionManager:Landroid/media/session/MediaSessionManager;

.field public mMediaTrackName:Landroid/widget/TextView;

.field public mMediaUxScrim:Landroid/view/View;

.field public mNavAllApps:Landroid/widget/ImageButton;

.field public mNavPinned:Landroid/widget/ImageButton;

.field public mNavRecent:Landroid/widget/ImageButton;

.field public final mPrimaryMediaComponent:Ljava/lang/String;

.field public final mSessionsListener:Landroid/media/session/MediaSessionManager$OnActiveSessionsChangedListener;


# direct methods
.method public static synthetic $r8$lambda$-D0GZIgCzcWV65At4ZOXDOwdkCc(Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;Ljava/util/List;)V
    .registers 2

    .line 0
    invoke-virtual {p0, p1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->lambda$new$0(Ljava/util/List;)V

    return-void
.end method

.method public static synthetic $r8$lambda$4KcvO_it4C7ItxasyKTS9elSuKg(Landroid/view/View;)V
    .registers 2

    .line 185
    new-instance p0, Lcom/android/car/scalableui/model/Event$Builder;

    const-string v0, "toggle_fullscreen"

    invoke-direct {p0, v0}, Lcom/android/car/scalableui/model/Event$Builder;-><init>(Ljava/lang/String;)V

    .line 186
    invoke-virtual {p0}, Lcom/android/car/scalableui/model/Event$Builder;->build()Lcom/android/car/scalableui/model/Event;

    move-result-object p0

    .line 185
    invoke-static {p0}, Lcom/android/car/scalableui/manager/StateManager;->handleEvent(Lcom/android/car/scalableui/model/Event;)Lcom/android/car/scalableui/model/PanelTransaction;

    return-void
.end method

.method public static synthetic $r8$lambda$7xeKH6oCGCob1688y8-k7L4sxfA(Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;Landroid/view/View;)V
    .registers 2

    .line 0
    invoke-virtual {p0, p1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->lambda$wireClickListeners$4(Landroid/view/View;)V

    return-void
.end method

.method public static synthetic $r8$lambda$CsdZ7baMehz1wNw3pK1a91sYcdE(Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;Landroid/view/View;)V
    .registers 2

    .line 0
    invoke-virtual {p0, p1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->lambda$wireClickListeners$3(Landroid/view/View;)V

    return-void
.end method

.method public static synthetic $r8$lambda$Dx6B-uIsb4Zs73kQUUJdPipla_g(Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;Ljava/util/List;)V
    .registers 2

    .line 0
    invoke-virtual {p0, p1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->lambda$new$1(Ljava/util/List;)V

    return-void
.end method

.method public static synthetic $r8$lambda$LFNzOwQqIEcanIEfKVTKoesPA0w(Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;Landroid/view/View;)V
    .registers 2

    .line 0
    invoke-virtual {p0, p1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->lambda$wireClickListeners$8(Landroid/view/View;)V

    return-void
.end method

.method public static synthetic $r8$lambda$pBH1OTQzULvgf0vyshhba6LP3YA(Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;Landroid/view/View;)V
    .registers 2

    .line 0
    invoke-virtual {p0, p1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->lambda$wireClickListeners$6(Landroid/view/View;)V

    return-void
.end method

.method public static synthetic $r8$lambda$tZ3GfvhaKtOkb7xFOsiG_g6HnZE(Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;Landroid/view/View;)V
    .registers 2

    .line 0
    invoke-virtual {p0, p1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->lambda$wireClickListeners$2(Landroid/view/View;)V

    return-void
.end method

.method public static synthetic $r8$lambda$wJ_MEIfIzXZajsh9PeazRscYQQQ(Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;Landroid/view/View;)V
    .registers 2

    .line 0
    invoke-virtual {p0, p1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->lambda$wireClickListeners$7(Landroid/view/View;)V

    return-void
.end method

.method public static bridge synthetic -$$Nest$mupdatePlaybackUi(Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;Landroid/media/session/PlaybackState;)V
    .registers 2

    .line 0
    invoke-virtual {p0, p1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->updatePlaybackUi(Landroid/media/session/PlaybackState;)V

    return-void
.end method

.method public static bridge synthetic -$$Nest$mupdateTrackTitle(Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;Landroid/media/MediaMetadata;)V
    .registers 2

    .line 0
    invoke-virtual {p0, p1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->updateTrackTitle(Landroid/media/MediaMetadata;)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .registers 6

    .line 99
    invoke-direct {p0, p1, p2, p3}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableBarControllerBase;-><init>(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V

    const/4 p1, 0x1

    .line 57
    iput-boolean p1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->mMediaPanelVisible:Z

    .line 76
    new-instance p1, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController$$ExternalSyntheticLambda0;

    invoke-direct {p1, p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController$$ExternalSyntheticLambda0;-><init>(Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;)V

    iput-object p1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->mSessionsListener:Landroid/media/session/MediaSessionManager$OnActiveSessionsChangedListener;

    .line 80
    new-instance p1, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController$1;

    invoke-direct {p1, p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController$1;-><init>(Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;)V

    iput-object p1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->mMediaCallback:Landroid/media/session/MediaController$Callback;

    .line 100
    iput-object p4, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->mPrimaryMediaComponent:Ljava/lang/String;

    .line 101
    iput-object p5, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->mMediaPanelId:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public applyUxRestrictions()V
    .registers 3

    .line 371
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->mFooterUxScrim:Landroid/view/View;

    iget-boolean v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableBarControllerBase;->mFullyRestricted:Z

    invoke-virtual {p0, v0, v1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableBarControllerBase;->setScrimVisible(Landroid/view/View;Z)V

    .line 372
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->mMediaUxScrim:Landroid/view/View;

    iget-boolean v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableBarControllerBase;->mFullyRestricted:Z

    invoke-virtual {p0, v0, v1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableBarControllerBase;->setScrimVisible(Landroid/view/View;Z)V

    .line 373
    iget-boolean v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableBarControllerBase;->mFullyRestricted:Z

    xor-int/lit8 v0, v0, 0x1

    .line 374
    iget-object v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->mNavAllApps:Landroid/widget/ImageButton;

    invoke-virtual {p0, v1, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableBarControllerBase;->setViewEnabled(Landroid/view/View;Z)V

    .line 375
    iget-object v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->mNavRecent:Landroid/widget/ImageButton;

    invoke-virtual {p0, v1, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableBarControllerBase;->setViewEnabled(Landroid/view/View;Z)V

    .line 376
    iget-object v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->mNavPinned:Landroid/widget/ImageButton;

    invoke-virtual {p0, v1, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableBarControllerBase;->setViewEnabled(Landroid/view/View;Z)V

    .line 377
    iget-object v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->mMediaPrev:Landroid/widget/ImageButton;

    invoke-virtual {p0, v1, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableBarControllerBase;->setViewEnabled(Landroid/view/View;Z)V

    .line 378
    iget-object v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->mMediaPlayPause:Landroid/widget/ImageButton;

    invoke-virtual {p0, v1, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableBarControllerBase;->setViewEnabled(Landroid/view/View;Z)V

    .line 379
    iget-object v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->mMediaNext:Landroid/widget/ImageButton;

    invoke-virtual {p0, v1, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableBarControllerBase;->setViewEnabled(Landroid/view/View;Z)V

    return-void
.end method

.method public applyVhalConnectedState()V
    .registers 1

    return-void
.end method

.method public applyVhalDisconnectedState()V
    .registers 1

    return-void
.end method

.method public final bindActiveMediaController(Ljava/util/List;)V
    .registers 3

    .line 241
    invoke-virtual {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->unbindMediaController()V

    if-eqz p1, :cond_2d

    .line 242
    invoke-interface {p1}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_c

    goto :goto_2d

    :cond_c
    const/4 v0, 0x0

    .line 246
    invoke-interface {p1, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Landroid/media/session/MediaController;

    iput-object p1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->mActiveController:Landroid/media/session/MediaController;

    .line 247
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->mMediaCallback:Landroid/media/session/MediaController$Callback;

    invoke-virtual {p1, v0}, Landroid/media/session/MediaController;->registerCallback(Landroid/media/session/MediaController$Callback;)V

    .line 248
    iget-object p1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->mActiveController:Landroid/media/session/MediaController;

    invoke-virtual {p1}, Landroid/media/session/MediaController;->getPlaybackState()Landroid/media/session/PlaybackState;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->updatePlaybackUi(Landroid/media/session/PlaybackState;)V

    .line 249
    iget-object p1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->mActiveController:Landroid/media/session/MediaController;

    invoke-virtual {p1}, Landroid/media/session/MediaController;->getMetadata()Landroid/media/MediaMetadata;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->updateTrackTitle(Landroid/media/MediaMetadata;)V

    return-void

    .line 243
    :cond_2d
    :goto_2d
    invoke-virtual {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->setDefaultTrackTitle()V

    return-void
.end method

.method public final bindFooterNav(Landroid/view/View;)V
    .registers 3

    .line 148
    const-string v0, "sysui_nav_all_apps"

    invoke-virtual {p0, p1, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->findButton(Landroid/view/View;Ljava/lang/String;)Landroid/widget/ImageButton;

    move-result-object v0

    iput-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->mNavAllApps:Landroid/widget/ImageButton;

    .line 149
    const-string v0, "sysui_nav_recent"

    invoke-virtual {p0, p1, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->findButton(Landroid/view/View;Ljava/lang/String;)Landroid/widget/ImageButton;

    move-result-object v0

    iput-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->mNavRecent:Landroid/widget/ImageButton;

    .line 150
    const-string v0, "sysui_nav_pinned"

    invoke-virtual {p0, p1, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->findButton(Landroid/view/View;Ljava/lang/String;)Landroid/widget/ImageButton;

    move-result-object v0

    iput-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->mNavPinned:Landroid/widget/ImageButton;

    .line 151
    const-string v0, "sysui_footer_fullscreen_toggle"

    invoke-virtual {p0, p1, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->findButton(Landroid/view/View;Ljava/lang/String;)Landroid/widget/ImageButton;

    move-result-object v0

    iput-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->mFullscreenToggle:Landroid/widget/ImageButton;

    .line 152
    const-string v0, "sysui_footer_ux_scrim"

    invoke-virtual {p0, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableBarControllerBase;->resolveRroId(Ljava/lang/String;)I

    move-result v0

    if-eqz v0, :cond_2d

    .line 153
    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    goto :goto_2e

    :cond_2d
    const/4 p1, 0x0

    :goto_2e
    iput-object p1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->mFooterUxScrim:Landroid/view/View;

    return-void
.end method

.method public final bindMediaControls(Landroid/view/View;)V
    .registers 4

    .line 157
    const-string v0, "sysui_footer_media_root"

    invoke-virtual {p0, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableBarControllerBase;->resolveRroId(Ljava/lang/String;)I

    move-result v0

    if-eqz v0, :cond_d

    .line 158
    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    goto :goto_e

    :cond_d
    move-object v0, p1

    :goto_e
    iput-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->mMediaRoot:Landroid/view/View;

    .line 159
    const-string v0, "sysui_media_prev"

    invoke-virtual {p0, p1, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->findButton(Landroid/view/View;Ljava/lang/String;)Landroid/widget/ImageButton;

    move-result-object v0

    iput-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->mMediaPrev:Landroid/widget/ImageButton;

    .line 160
    const-string v0, "sysui_media_play_pause"

    invoke-virtual {p0, p1, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->findButton(Landroid/view/View;Ljava/lang/String;)Landroid/widget/ImageButton;

    move-result-object v0

    iput-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->mMediaPlayPause:Landroid/widget/ImageButton;

    .line 161
    const-string v0, "sysui_media_next"

    invoke-virtual {p0, p1, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->findButton(Landroid/view/View;Ljava/lang/String;)Landroid/widget/ImageButton;

    move-result-object v0

    iput-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->mMediaNext:Landroid/widget/ImageButton;

    .line 162
    const-string v0, "sysui_media_track_name"

    invoke-virtual {p0, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableBarControllerBase;->resolveRroId(Ljava/lang/String;)I

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_38

    .line 163
    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    goto :goto_39

    :cond_38
    move-object v0, v1

    :goto_39
    iput-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->mMediaTrackName:Landroid/widget/TextView;

    .line 164
    const-string v0, "sysui_media_ux_scrim"

    invoke-virtual {p0, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableBarControllerBase;->resolveRroId(Ljava/lang/String;)I

    move-result v0

    if-eqz v0, :cond_47

    .line 165
    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    :cond_47
    iput-object v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->mMediaUxScrim:Landroid/view/View;

    return-void
.end method

.method public bindViews(Landroid/view/View;)V
    .registers 2

    .line 142
    invoke-virtual {p0, p1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->bindFooterNav(Landroid/view/View;)V

    .line 143
    invoke-virtual {p0, p1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->bindMediaControls(Landroid/view/View;)V

    .line 144
    invoke-virtual {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->wireClickListeners()V

    return-void
.end method

.method public final dispatchMediaKey(I)V
    .registers 7

    .line 276
    iget-boolean v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableBarControllerBase;->mFullyRestricted:Z

    if-eqz v0, :cond_5

    return-void

    .line 279
    :cond_5
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->mActiveController:Landroid/media/session/MediaController;

    if-eqz v0, :cond_2e

    const/16 v1, 0x57

    if-eq p1, v1, :cond_26

    const/16 v1, 0x58

    if-eq p1, v1, :cond_1e

    const/16 v1, 0x7e

    if-eq p1, v1, :cond_16

    goto :goto_2e

    .line 288
    :cond_16
    invoke-virtual {v0}, Landroid/media/session/MediaController;->getTransportControls()Landroid/media/session/MediaController$TransportControls;

    move-result-object p0

    invoke-virtual {p0}, Landroid/media/session/MediaController$TransportControls;->play()V

    return-void

    .line 282
    :cond_1e
    invoke-virtual {v0}, Landroid/media/session/MediaController;->getTransportControls()Landroid/media/session/MediaController$TransportControls;

    move-result-object p0

    invoke-virtual {p0}, Landroid/media/session/MediaController$TransportControls;->skipToPrevious()V

    return-void

    .line 285
    :cond_26
    invoke-virtual {v0}, Landroid/media/session/MediaController;->getTransportControls()Landroid/media/session/MediaController$TransportControls;

    move-result-object p0

    invoke-virtual {p0}, Landroid/media/session/MediaController$TransportControls;->skipToNext()V

    return-void

    .line 294
    :cond_2e
    :goto_2e
    new-instance v0, Landroid/view/KeyEvent;

    const/4 v1, 0x0

    invoke-direct {v0, v1, p1}, Landroid/view/KeyEvent;-><init>(II)V

    .line 295
    new-instance v1, Landroid/view/KeyEvent;

    const/4 v2, 0x1

    invoke-direct {v1, v2, p1}, Landroid/view/KeyEvent;-><init>(II)V

    .line 296
    iget-object p1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableBarControllerBase;->mContext:Landroid/content/Context;

    new-instance v2, Landroid/content/Intent;

    const-string v3, "android.intent.action.MEDIA_BUTTON"

    invoke-direct {v2, v3}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 297
    const-string v4, "android.intent.extra.KEY_EVENT"

    invoke-virtual {v2, v4, v0}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Landroid/os/Parcelable;)Landroid/content/Intent;

    move-result-object v0

    const/4 v2, 0x0

    .line 296
    invoke-virtual {p1, v0, v2}, Landroid/content/Context;->sendOrderedBroadcast(Landroid/content/Intent;Ljava/lang/String;)V

    .line 298
    iget-object p0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableBarControllerBase;->mContext:Landroid/content/Context;

    new-instance p1, Landroid/content/Intent;

    invoke-direct {p1, v3}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 299
    invoke-virtual {p1, v4, v1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Landroid/os/Parcelable;)Landroid/content/Intent;

    move-result-object p1

    .line 298
    invoke-virtual {p0, p1, v2}, Landroid/content/Context;->sendOrderedBroadcast(Landroid/content/Intent;Ljava/lang/String;)V

    return-void
.end method

.method public final dispatchScalableEvent(Lcom/android/car/scalableui/model/Event;)V
    .registers 5

    :try_start_0
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableBarControllerBase;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    check-cast v0, Lcom/android/systemui/application/impl/SystemUIApplicationImpl;

    invoke-virtual {v0}, Lcom/android/systemui/application/impl/SystemUIApplicationImpl;->getWMComponent()Lcom/android/wm/shell/dagger/WMComponent;

    move-result-object v0

    check-cast v0, Lcom/android/systemui/DaggerCarGlobalRootComponent$CarWMComponentImpl;

    invoke-virtual {v0}, Lcom/android/systemui/DaggerCarGlobalRootComponent$CarWMComponentImpl;->getScalableUIEventDispatcher()Lcom/android/systemui/car/wm/scalableui/EventDispatcher;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/android/systemui/car/wm/scalableui/EventDispatcher;->executeEvent(Lcom/android/car/scalableui/model/Event;)V
    :try_end_15
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_15} :catch_16

    return-void

    :catch_16
    :try_start_16
    invoke-static {p1}, Lcom/android/car/scalableui/manager/StateManager;->handleEvent(Lcom/android/car/scalableui/model/Event;)Lcom/android/car/scalableui/model/PanelTransaction;

    move-result-object v0

    if-eqz v0, :cond_3c

    invoke-virtual {v0}, Lcom/android/car/scalableui/model/PanelTransaction;->getAnimators()Ljava/util/Set;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_24
    :goto_24
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_3c

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/util/Map$Entry;

    invoke-interface {v1}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v1

    if-eqz v1, :cond_24

    check-cast v1, Landroid/animation/Animator;

    invoke-virtual {v1}, Landroid/animation/Animator;->start()V

    goto :goto_24
    :try_end_3c
    .catch Ljava/lang/Throwable; {:try_start_16 .. :try_end_3c} :catch_3c

    :catch_3c
    :cond_3c
    return-void
.end method

.method public final findButton(Landroid/view/View;Ljava/lang/String;)Landroid/widget/ImageButton;
    .registers 3

    .line 169
    invoke-virtual {p0, p2}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableBarControllerBase;->resolveRroId(Ljava/lang/String;)I

    move-result p0

    if-eqz p0, :cond_d

    .line 170
    invoke-virtual {p1, p0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p0

    check-cast p0, Landroid/widget/ImageButton;

    return-object p0

    :cond_d
    const/4 p0, 0x0

    return-object p0
.end method

.method public final getDefaultTrackTitleString()Ljava/lang/String;
    .registers 2

    .line 336
    const-string v0, "sysui_media_not_playing"

    invoke-virtual {p0, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableBarControllerBase;->resolveRroString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    if-eqz p0, :cond_9

    return-object p0

    .line 337
    :cond_9
    const-string p0, "Not Playing"

    return-object p0
.end method

.method public getLayoutResourceName()Ljava/lang/String;
    .registers 2

    .line 134
    const-string v0, "sysui_footer_media_panel"

    iget-object p0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableBarControllerBase;->mPanelId:Ljava/lang/String;

    invoke-virtual {v0, p0}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result p0

    if-eqz p0, :cond_d

    .line 135
    const-string p0, "car_sysui_scalable_footer_media"

    return-object p0

    .line 137
    :cond_d
    const-string p0, "car_sysui_scalable_footer"

    return-object p0
.end method

.method public final synthetic lambda$new$0(Ljava/util/List;)V
    .registers 2

    .line 78
    invoke-virtual {p0, p1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->bindActiveMediaController(Ljava/util/List;)V

    return-void
.end method

.method public final synthetic lambda$new$1(Ljava/util/List;)V
    .registers 3

    .line 77
    new-instance v0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController$$ExternalSyntheticLambda8;

    invoke-direct {v0, p0, p1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController$$ExternalSyntheticLambda8;-><init>(Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;Ljava/util/List;)V

    invoke-virtual {p0, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableBarControllerBase;->runOnViewThread(Ljava/lang/Runnable;)V

    return-void
.end method

.method public final synthetic lambda$wireClickListeners$2(Landroid/view/View;)V
    .registers 2

    .line 175
    invoke-virtual {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->launchAllApps()V

    return-void
.end method

.method public final synthetic lambda$wireClickListeners$3(Landroid/view/View;)V
    .registers 2

    .line 178
    invoke-virtual {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->launchRecent()V

    return-void
.end method

.method public final synthetic lambda$wireClickListeners$4(Landroid/view/View;)V
    .registers 2

    .line 181
    invoke-virtual {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->launchPinned()V

    return-void
.end method

.method public final synthetic lambda$wireClickListeners$6(Landroid/view/View;)V
    .registers 2

    const/16 p1, 0x58

    .line 190
    invoke-virtual {p0, p1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->dispatchMediaKey(I)V

    return-void
.end method

.method public final synthetic lambda$wireClickListeners$7(Landroid/view/View;)V
    .registers 2

    .line 193
    invoke-virtual {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->togglePlayPause()V

    return-void
.end method

.method public final synthetic lambda$wireClickListeners$8(Landroid/view/View;)V
    .registers 2

    const/16 p1, 0x57

    .line 196
    invoke-virtual {p0, p1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->dispatchMediaKey(I)V

    return-void
.end method

.method public final launchAllApps()V
    .registers 6

    iget-boolean v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableBarControllerBase;->mFullyRestricted:Z

    if-eqz v0, :cond_5

    return-void

    :cond_5
    const-string v0, "CarSysuiFooterCtrl"

    const-string v1, "launchAllApps half-screen"

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    new-instance v0, Lcom/android/car/scalableui/model/Event$Builder;

    const-string v1, "_System_TaskOpenEvent"

    invoke-direct {v0, v1}, Lcom/android/car/scalableui/model/Event$Builder;-><init>(Ljava/lang/String;)V

    const-string v1, "panel_app_grid"

    invoke-virtual {v0, v1}, Lcom/android/car/scalableui/model/Event$Builder;->setPanelId(Ljava/lang/String;)Lcom/android/car/scalableui/model/Event$Builder;

    invoke-virtual {v0}, Lcom/android/car/scalableui/model/Event$Builder;->build()Lcom/android/car/scalableui/model/Event;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->dispatchScalableEvent(Lcom/android/car/scalableui/model/Event;)V

    new-instance v0, Landroid/content/Intent;

    const-string v1, "com.android.car.carlauncher.ACTION_APP_GRID"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    const-string v1, "com.android.car.carlauncher"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setPackage(Ljava/lang/String;)Landroid/content/Intent;

    new-instance v2, Landroid/content/ComponentName;

    const-string v3, "com.android.car.carlauncher.AppGridActivity"

    invoke-direct {v2, v1, v3}, Landroid/content/ComponentName;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v0, v2}, Landroid/content/Intent;->setComponent(Landroid/content/ComponentName;)Landroid/content/Intent;

    const/high16 v1, 0x14000000

    invoke-virtual {v0, v1}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    invoke-static {}, Landroid/app/ActivityManager;->getCurrentUser()I

    move-result v1

    invoke-static {v1}, Landroid/os/UserHandle;->of(I)Landroid/os/UserHandle;

    move-result-object v1

    iget-object v2, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableBarControllerBase;->mContext:Landroid/content/Context;

    :try_start_44
    invoke-virtual {v2, v0, v1}, Landroid/content/Context;->startActivityAsUser(Landroid/content/Intent;Landroid/os/UserHandle;)V
    :try_end_47
    .catch Ljava/lang/Throwable; {:try_start_44 .. :try_end_47} :catch_48

    return-void

    :catch_48
    move-exception v1

    const-string v3, "CarSysuiFooterCtrl"

    const-string v4, "startActivityAsUser AppGrid failed"

    invoke-static {v3, v4, v1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    return-void
.end method

.method public final launchPinned()V
    .registers 4

    iget-boolean v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableBarControllerBase;->mFullyRestricted:Z

    if-eqz v0, :cond_5

    return-void

    :cond_5
    const-string v0, "CarSysuiFooterCtrl"

    const-string v1, "launchHome"

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    new-instance v0, Lcom/android/car/scalableui/model/Event$Builder;

    const-string v1, "_System_OnHomeEvent"

    invoke-direct {v0, v1}, Lcom/android/car/scalableui/model/Event$Builder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Lcom/android/car/scalableui/model/Event$Builder;->build()Lcom/android/car/scalableui/model/Event;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->dispatchScalableEvent(Lcom/android/car/scalableui/model/Event;)V

    new-instance v0, Lcom/android/car/scalableui/model/Event$Builder;

    const-string v1, "_System_TaskOpenEvent"

    invoke-direct {v0, v1}, Lcom/android/car/scalableui/model/Event$Builder;-><init>(Ljava/lang/String;)V

    const-string v1, "map_panel"

    invoke-virtual {v0, v1}, Lcom/android/car/scalableui/model/Event$Builder;->setPanelId(Ljava/lang/String;)Lcom/android/car/scalableui/model/Event$Builder;

    invoke-virtual {v0}, Lcom/android/car/scalableui/model/Event$Builder;->build()Lcom/android/car/scalableui/model/Event;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->dispatchScalableEvent(Lcom/android/car/scalableui/model/Event;)V

    return-void
.end method

.method public final launchRecent()V
    .registers 3

    .line 351
    iget-boolean v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableBarControllerBase;->mFullyRestricted:Z

    if-eqz v0, :cond_5

    return-void

    .line 354
    :cond_5
    new-instance v0, Landroid/content/Intent;

    const-string v1, "com.android.systemui.car.action.SHOW_RECENTS"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    const/high16 v1, 0x10000000

    .line 355
    invoke-virtual {v0, v1}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    .line 356
    iget-object p0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableBarControllerBase;->mContext:Landroid/content/Context;

    invoke-virtual {p0, v0}, Landroid/content/Context;->sendBroadcast(Landroid/content/Intent;)V

    return-void
.end method

.method public onControllerAttached()V
    .registers 4

    .line 202
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableBarControllerBase;->mContext:Landroid/content/Context;

    const-class v1, Landroid/media/session/MediaSessionManager;

    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/media/session/MediaSessionManager;

    iput-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->mMediaSessionManager:Landroid/media/session/MediaSessionManager;

    if-eqz v0, :cond_38

    .line 205
    :try_start_e
    new-instance v0, Landroid/content/ComponentName;

    iget-object v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableBarControllerBase;->mContext:Landroid/content/Context;

    .line 206
    invoke-virtual {v1}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v1

    const-string v2, "com.android.systemui.car.wm.scalableui.panel.controller.CarSysuiScalableFooterController"

    invoke-direct {v0, v1, v2}, Landroid/content/ComponentName;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .line 208
    iget-object v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->mMediaSessionManager:Landroid/media/session/MediaSessionManager;

    iget-object v2, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->mSessionsListener:Landroid/media/session/MediaSessionManager$OnActiveSessionsChangedListener;

    invoke-virtual {v1, v2, v0}, Landroid/media/session/MediaSessionManager;->addOnActiveSessionsChangedListener(Landroid/media/session/MediaSessionManager$OnActiveSessionsChangedListener;Landroid/content/ComponentName;)V

    .line 210
    iget-object v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->mMediaSessionManager:Landroid/media/session/MediaSessionManager;

    .line 211
    invoke-virtual {v1, v0}, Landroid/media/session/MediaSessionManager;->getActiveSessions(Landroid/content/ComponentName;)Ljava/util/List;

    move-result-object v0

    .line 210
    invoke-virtual {p0, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->bindActiveMediaController(Ljava/util/List;)V
    :try_end_2b
    .catch Ljava/lang/SecurityException; {:try_start_e .. :try_end_2b} :catch_2c

    return-void

    :catch_2c
    move-exception v0

    .line 213
    const-string v1, "CarSysuiFooterCtrl"

    const-string v2, "Media session access denied \u2014 using key-event fallback"

    invoke-static {v1, v2, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    const/4 v0, 0x0

    .line 214
    invoke-virtual {p0, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->bindActiveMediaController(Ljava/util/List;)V

    :cond_38
    return-void
.end method

.method public onControllerDetached()V
    .registers 3

    .line 221
    invoke-virtual {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->unbindMediaController()V

    .line 222
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->mMediaSessionManager:Landroid/media/session/MediaSessionManager;

    if-eqz v0, :cond_15

    .line 224
    :try_start_7
    iget-object p0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->mSessionsListener:Landroid/media/session/MediaSessionManager$OnActiveSessionsChangedListener;

    invoke-virtual {v0, p0}, Landroid/media/session/MediaSessionManager;->removeOnActiveSessionsChangedListener(Landroid/media/session/MediaSessionManager$OnActiveSessionsChangedListener;)V
    :try_end_c
    .catch Ljava/lang/Exception; {:try_start_7 .. :try_end_c} :catch_d

    return-void

    :catch_d
    move-exception p0

    .line 226
    const-string v0, "CarSysuiFooterCtrl"

    const-string v1, "Failed to remove sessions listener"

    invoke-static {v0, v1, p0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    :cond_15
    return-void
.end method

.method public final setDefaultTrackTitle()V
    .registers 2

    .line 330
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->mMediaTrackName:Landroid/widget/TextView;

    if-eqz v0, :cond_b

    .line 331
    invoke-virtual {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->getDefaultTrackTitleString()Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v0, p0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    :cond_b
    return-void
.end method

.method public final togglePlayPause()V
    .registers 3

    .line 260
    iget-boolean v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableBarControllerBase;->mFullyRestricted:Z

    if-eqz v0, :cond_5

    return-void

    .line 263
    :cond_5
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->mActiveController:Landroid/media/session/MediaController;

    if-nez v0, :cond_f

    const/16 v0, 0x7e

    .line 264
    invoke-virtual {p0, v0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->dispatchMediaKey(I)V

    return-void

    .line 267
    :cond_f
    invoke-virtual {v0}, Landroid/media/session/MediaController;->getPlaybackState()Landroid/media/session/PlaybackState;

    move-result-object v0

    if-eqz v0, :cond_26

    .line 268
    invoke-virtual {v0}, Landroid/media/session/PlaybackState;->getState()I

    move-result v0

    const/4 v1, 0x3

    if-ne v0, v1, :cond_26

    .line 269
    iget-object p0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->mActiveController:Landroid/media/session/MediaController;

    invoke-virtual {p0}, Landroid/media/session/MediaController;->getTransportControls()Landroid/media/session/MediaController$TransportControls;

    move-result-object p0

    invoke-virtual {p0}, Landroid/media/session/MediaController$TransportControls;->pause()V

    return-void

    .line 271
    :cond_26
    iget-object p0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->mActiveController:Landroid/media/session/MediaController;

    invoke-virtual {p0}, Landroid/media/session/MediaController;->getTransportControls()Landroid/media/session/MediaController$TransportControls;

    move-result-object p0

    invoke-virtual {p0}, Landroid/media/session/MediaController$TransportControls;->play()V

    return-void
.end method

.method public final unbindMediaController()V
    .registers 3

    .line 253
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->mActiveController:Landroid/media/session/MediaController;

    if-eqz v0, :cond_c

    .line 254
    iget-object v1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->mMediaCallback:Landroid/media/session/MediaController$Callback;

    invoke-virtual {v0, v1}, Landroid/media/session/MediaController;->unregisterCallback(Landroid/media/session/MediaController$Callback;)V

    const/4 v0, 0x0

    .line 255
    iput-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->mActiveController:Landroid/media/session/MediaController;

    :cond_c
    return-void
.end method

.method public final updatePlaybackUi(Landroid/media/session/PlaybackState;)V
    .registers 3

    .line 303
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->mMediaPlayPause:Landroid/widget/ImageButton;

    if-nez v0, :cond_5

    goto :goto_25

    :cond_5
    if-eqz p1, :cond_10

    .line 306
    invoke-virtual {p1}, Landroid/media/session/PlaybackState;->getState()I

    move-result p1

    const/4 v0, 0x3

    if-ne p1, v0, :cond_10

    const/4 p1, 0x1

    goto :goto_11

    :cond_10
    const/4 p1, 0x0

    :goto_11
    iput-boolean p1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->mIsPlaying:Z

    if-eqz p1, :cond_18

    .line 307
    const-string p1, "ic_sysui_media_pause"

    goto :goto_1a

    .line 308
    :cond_18
    const-string p1, "ic_sysui_media_play"

    .line 307
    :goto_1a
    invoke-virtual {p0, p1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableBarControllerBase;->resolveRroDrawable(Ljava/lang/String;)I

    move-result p1

    if-eqz p1, :cond_25

    .line 310
    iget-object p0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->mMediaPlayPause:Landroid/widget/ImageButton;

    invoke-virtual {p0, p1}, Landroid/widget/ImageButton;->setImageResource(I)V

    :cond_25
    :goto_25
    return-void
.end method

.method public final updateTrackTitle(Landroid/media/MediaMetadata;)V
    .registers 4

    .line 315
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->mMediaTrackName:Landroid/widget/TextView;

    if-nez v0, :cond_5

    return-void

    :cond_5
    if-nez p1, :cond_b

    .line 319
    invoke-virtual {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->setDefaultTrackTitle()V

    return-void

    .line 322
    :cond_b
    const-string v0, "android.media.metadata.TITLE"

    invoke-virtual {p1, v0}, Landroid/media/MediaMetadata;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_19

    .line 323
    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-eqz v1, :cond_1f

    .line 324
    :cond_19
    const-string v0, "android.media.metadata.DISPLAY_TITLE"

    invoke-virtual {p1, v0}, Landroid/media/MediaMetadata;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 326
    :cond_1f
    iget-object p1, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->mMediaTrackName:Landroid/widget/TextView;

    if-eqz v0, :cond_24

    goto :goto_28

    :cond_24
    invoke-virtual {p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->getDefaultTrackTitleString()Ljava/lang/String;

    move-result-object v0

    :goto_28
    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void
.end method

.method public final wireClickListeners()V
    .registers 3

    .line 174
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->mNavAllApps:Landroid/widget/ImageButton;

    if-eqz v0, :cond_c

    .line 175
    new-instance v1, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController$$ExternalSyntheticLambda1;

    invoke-direct {v1, p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController$$ExternalSyntheticLambda1;-><init>(Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;)V

    invoke-virtual {v0, v1}, Landroid/widget/ImageButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 177
    :cond_c
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->mNavRecent:Landroid/widget/ImageButton;

    if-eqz v0, :cond_18

    .line 178
    new-instance v1, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController$$ExternalSyntheticLambda2;

    invoke-direct {v1, p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController$$ExternalSyntheticLambda2;-><init>(Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;)V

    invoke-virtual {v0, v1}, Landroid/widget/ImageButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 180
    :cond_18
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->mNavPinned:Landroid/widget/ImageButton;

    if-eqz v0, :cond_24

    .line 181
    new-instance v1, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController$$ExternalSyntheticLambda3;

    invoke-direct {v1, p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController$$ExternalSyntheticLambda3;-><init>(Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;)V

    invoke-virtual {v0, v1}, Landroid/widget/ImageButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 183
    :cond_24
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->mFullscreenToggle:Landroid/widget/ImageButton;

    if-eqz v0, :cond_30

    .line 184
    new-instance v1, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController$$ExternalSyntheticLambda4;

    invoke-direct {v1}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController$$ExternalSyntheticLambda4;-><init>()V

    invoke-virtual {v0, v1}, Landroid/widget/ImageButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 189
    :cond_30
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->mMediaPrev:Landroid/widget/ImageButton;

    if-eqz v0, :cond_3c

    .line 190
    new-instance v1, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController$$ExternalSyntheticLambda5;

    invoke-direct {v1, p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController$$ExternalSyntheticLambda5;-><init>(Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;)V

    invoke-virtual {v0, v1}, Landroid/widget/ImageButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 192
    :cond_3c
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->mMediaPlayPause:Landroid/widget/ImageButton;

    if-eqz v0, :cond_48

    .line 193
    new-instance v1, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController$$ExternalSyntheticLambda6;

    invoke-direct {v1, p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController$$ExternalSyntheticLambda6;-><init>(Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;)V

    invoke-virtual {v0, v1}, Landroid/widget/ImageButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 195
    :cond_48
    iget-object v0, p0, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;->mMediaNext:Landroid/widget/ImageButton;

    if-eqz v0, :cond_54

    .line 196
    new-instance v1, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController$$ExternalSyntheticLambda7;

    invoke-direct {v1, p0}, Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController$$ExternalSyntheticLambda7;-><init>(Lcom/android/systemui/car/wm/scalableui/panel/controller/CarSysuiScalableFooterController;)V

    invoke-virtual {v0, v1}, Landroid/widget/ImageButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    :cond_54
    return-void
.end method
