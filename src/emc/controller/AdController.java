package emc.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import emc.beans.Ad;
import emc.service.AdService;

@Controller
public class AdController {
	private AdService ads;

	public AdService getAds() {
		return ads;
	}

	public void setAds(AdService ads) {
		this.ads = ads;
	}

	@RequestMapping(value = "/get_ad", method = RequestMethod.POST)
	@ResponseBody
	public Ad getAd(@RequestParam(value = "adId") int adId,
			HttpServletRequest request) {

		return ads.findAdByAdId(adId);
	}

	@RequestMapping(value = "/edit_ad", method = RequestMethod.POST)
	@ResponseBody
	public int editAd(@RequestParam(value = "adId") int adId,

	HttpServletRequest request) {


		return ads.editAd(adId);
		
	}

}
