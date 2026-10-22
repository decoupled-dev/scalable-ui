package com.scalableui.widgets.apps;

import android.app.Activity;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.content.pm.ResolveInfo;
import android.os.Bundle;
import android.util.TypedValue;
import android.view.View;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import java.util.Collections;
import java.util.List;

public class WidgetActivity extends Activity {
    private static final int SHOWN = 4;

    private LinearLayout list;
    private TextView empty;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.widget);
        list = findViewById(R.id.list);
        empty = findViewById(R.id.empty);
    }

    @Override
    protected void onResume() {
        super.onResume();
        bind();
    }

    private void bind() {
        list.removeAllViews();
        Intent launcher = new Intent(Intent.ACTION_MAIN).addCategory(Intent.CATEGORY_LAUNCHER);
        PackageManager packages = getPackageManager();
        List<ResolveInfo> apps = packages.queryIntentActivities(launcher, PackageManager.MATCH_ALL);
        Collections.sort(apps, (left, right) -> String.valueOf(left.loadLabel(packages))
                .compareToIgnoreCase(String.valueOf(right.loadLabel(packages))));
        if (apps.isEmpty()) {
            empty.setVisibility(View.VISIBLE);
            list.setVisibility(View.GONE);
            return;
        }
        empty.setVisibility(View.GONE);
        list.setVisibility(View.VISIBLE);
        int gap = dp(6);
        LinearLayout row = null;
        int shown = 0;
        for (ResolveInfo info : apps) {
            if (shown == SHOWN) {
                break;
            }
            if (shown % 2 == 0) {
                row = new LinearLayout(this);
                row.setOrientation(LinearLayout.HORIZONTAL);
                list.addView(row, new LinearLayout.LayoutParams(
                        LinearLayout.LayoutParams.MATCH_PARENT,
                        0,
                        1f));
            }
            View cell = getLayoutInflater().inflate(R.layout.app_cell, row, false);
            ImageView icon = cell.findViewById(R.id.icon);
            TextView label = cell.findViewById(R.id.label);
            CharSequence name = info.loadLabel(packages);
            icon.setImageDrawable(info.loadIcon(packages));
            label.setText(name);
            cell.setContentDescription(name);
            LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(
                    0, LinearLayout.LayoutParams.MATCH_PARENT, 1f);
            params.setMargins(gap, gap, gap, gap);
            row.addView(cell, params);
            shown++;
        }
        if (shown % 2 == 1 && row != null) {
            View spacer = new View(this);
            row.addView(spacer, new LinearLayout.LayoutParams(
                    0, LinearLayout.LayoutParams.MATCH_PARENT, 1f));
        }
    }

    private int dp(int value) {
        return (int) TypedValue.applyDimension(
                TypedValue.COMPLEX_UNIT_DIP, value, getResources().getDisplayMetrics());
    }
}
