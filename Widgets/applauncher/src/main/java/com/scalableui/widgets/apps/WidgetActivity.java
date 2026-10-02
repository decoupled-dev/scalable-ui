package com.scalableui.widgets.apps;

import android.app.Activity;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.content.pm.ResolveInfo;
import android.os.Bundle;
import android.util.TypedValue;
import android.widget.LinearLayout;
import android.widget.TextView;

import java.util.Collections;
import java.util.List;

public class WidgetActivity extends Activity {
    private LinearLayout list;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.widget);
        list = findViewById(R.id.list);
    }

    @Override
    protected void onResume() {
        super.onResume();
        bind();
    }

    private void bind() {
        list.removeAllViews();
        Intent launcher = new Intent(Intent.ACTION_MAIN).addCategory(Intent.CATEGORY_LAUNCHER);
        List<ResolveInfo> apps = getPackageManager().queryIntentActivities(launcher, PackageManager.MATCH_ALL);
        Collections.sort(apps, (left, right) -> String.valueOf(left.loadLabel(getPackageManager()))
                .compareToIgnoreCase(String.valueOf(right.loadLabel(getPackageManager()))));
        if (apps.isEmpty()) {
            list.addView(label("No launcher apps"));
            return;
        }
        int shown = 0;
        for (ResolveInfo info : apps) {
            if (shown == 12) {
                break;
            }
            list.addView(label(String.valueOf(info.loadLabel(getPackageManager()))));
            shown++;
        }
    }

    private TextView label(String text) {
        TextView view = new TextView(this);
        view.setText(text);
        view.setTextAppearance(com.scalableui.widgets.carprop.R.style.Widget_Label);
        view.setTextColor(getColor(com.scalableui.widgets.carprop.R.color.widget_text));
        view.setTextSize(TypedValue.COMPLEX_UNIT_SP, 16);
        int pad = (int) TypedValue.applyDimension(TypedValue.COMPLEX_UNIT_DIP, 8, getResources().getDisplayMetrics());
        view.setPadding(0, 0, 0, pad);
        return view;
    }
}
