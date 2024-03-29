﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DTO;
namespace DAL
{
    public class HoSoDAL
    {
        #region instance

        private static HoSoDAL instance;

        public static HoSoDAL Instance
        {
            get
            {
                if (instance == null) instance = new HoSoDAL();
                return instance;
            }
            private set { instance = value; }
        }

        private HoSoDAL()
        {
        }

        #endregion
        QL_THPTDataContext dataContext = new QL_THPTDataContext();
        public List<HoSo_PP> GetHoSo()
        {
            return (from hs in dataContext.HoSos
                    select new HoSo_PP
                    {
                        MaHoSo = hs.MaHoSo,
                        TenHS = hs.TenHoSo,
                        SoLuongToiDan = (int)hs.SoLuongToiDa,
                        SoLuongGhiNhan = 0,
                        GhiChu = hs.GhiChu,
                    }).ToList();
        }
    }
}
