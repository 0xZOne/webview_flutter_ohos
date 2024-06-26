/*
* Copyright (c) 2023 Hunan OpenValley Digital Industry Development Co., Ltd.
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
*     http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*/

import { WebSettingsHostApi } from './GeneratedOhosWebView';
import { InstanceManager } from './InstanceManager';
import { WebViewPlatformView } from './WebViewHostApiImpl';

export interface WebSettings {
  setDomStorageEnabled(flag: boolean): void;

  setJavaScriptCanOpenWindowsAutomatically(flag: boolean): void;

  setSupportMultipleWindows(support: boolean): void;

  setBackgroundColor(color: number): void;

  setJavaScriptEnabled(flag: boolean): void;

  setUserAgentString(userAgentString: string): void;

  setMediaPlaybackRequiresUserGesture(require: boolean): void;

  setSupportZoom(support: boolean): void;

  setLoadWithOverviewMode(overview: boolean): void;

  setUseWideViewPort(use: boolean): void;

  setDisplayZoomControls(enabled: boolean): void;

  setBuiltInZoomControls(enabled: boolean): void;

  setAllowFileAccess(enabled: boolean): void;

  setTextZoom(textZoom: number): void;
}

export class WebSettingsCreator {
  createWebSettings(webView: WebViewPlatformView): WebSettings {
    return webView.getWebSettings();
  }
}

export class WebSettingsHostApiImpl extends WebSettingsHostApi {
  private instanceManager: InstanceManager;

  private webSettingsCreator: WebSettingsCreator;

  constructor(instanceManager: InstanceManager, webSettingsCreator: WebSettingsCreator) {
    super();
    this.instanceManager = instanceManager;
    this.webSettingsCreator = webSettingsCreator;
  }

  create(instanceId: number, webViewInstanceId: number) {
    const webView: WebViewPlatformView = this.instanceManager.getInstance(webViewInstanceId);
    this.instanceManager.addDartCreatedInstance(this.webSettingsCreator.createWebSettings(webView), instanceId);
  }

  setDomStorageEnabled(instanceId: number, flag: boolean) {
    const webSettings:WebSettings = this.instanceManager.getInstance(instanceId);
    webSettings.setDomStorageEnabled(flag);
  }

  setJavaScriptCanOpenWindowsAutomatically(instanceId: number, flag: boolean) {
    const webSettings:WebSettings = this.instanceManager.getInstance(instanceId);
    webSettings.setJavaScriptCanOpenWindowsAutomatically(flag);
  }

  setSupportMultipleWindows(instanceId: number, support: boolean) {
    const webSettings:WebSettings = this.instanceManager.getInstance(instanceId);
    webSettings.setSupportMultipleWindows(support);
  }

  setBackgroundColor(instanceId: number, color: number) {
    const webSettings:WebSettings = this.instanceManager.getInstance(instanceId);
    webSettings.setBackgroundColor(color);
  }

  setJavaScriptEnabled(instanceId: number, flag: boolean) {
    const webSettings:WebSettings = this.instanceManager.getInstance(instanceId);
    webSettings.setJavaScriptEnabled(flag);
  }

  setUserAgentString(instanceId: number, userAgentString: string) {
    const webSettings:WebSettings = this.instanceManager.getInstance(instanceId);
    webSettings.setUserAgentString(userAgentString);
  }

  setMediaPlaybackRequiresUserGesture(instanceId: number, require: boolean) {
    const webSettings:WebSettings = this.instanceManager.getInstance(instanceId);
    webSettings.setMediaPlaybackRequiresUserGesture(require);
  }

  setSupportZoom(instanceId: number, support: boolean) {
    const webSettings:WebSettings = this.instanceManager.getInstance(instanceId);
    webSettings.setSupportZoom(support);
  }

  setLoadWithOverviewMode(instanceId: number, overview: boolean) {
    const webSettings:WebSettings = this.instanceManager.getInstance(instanceId);
    webSettings.setLoadWithOverviewMode(overview);
  }

  setUseWideViewPort(instanceId: number, use: boolean) {
    const webSettings:WebSettings = this.instanceManager.getInstance(instanceId);
    webSettings.setUseWideViewPort(use);
  }

  setDisplayZoomControls(instanceId: number, enabled: boolean) {
    const webSettings:WebSettings = this.instanceManager.getInstance(instanceId);
    webSettings.setDisplayZoomControls(enabled);
  }

  setBuiltInZoomControls(instanceId: number, enabled: boolean) {
    const webSettings:WebSettings = this.instanceManager.getInstance(instanceId);
    webSettings.setBuiltInZoomControls(enabled);
  }

  setAllowFileAccess(instanceId: number, enabled: boolean) {
    const webSettings:WebSettings = this.instanceManager.getInstance(instanceId);
    webSettings.setAllowFileAccess(enabled);
  }

  setTextZoom(instanceId: number, textZoom: number) {
    const webSettings:WebSettings = this.instanceManager.getInstance(instanceId);
    webSettings.setTextZoom(textZoom);
  }
}