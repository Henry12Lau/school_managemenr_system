import ECommerce from "@/components/Dashboard/E-commerce";
import { Metadata } from "next";
import DefaultLayout from "@/components/Layouts/DefaultLaout";
import React from "react";
import Signin from "@/components/Auth/Signin";

export const metadata: Metadata = {
  title:
    "School Management System"
};

export default function Home() {
  return (
    <>
    <Signin />
      {/* <DefaultLayout>
        <ECommerce />
      </DefaultLayout> */}
    </>
  );
}
