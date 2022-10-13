//
//  BadgeBackground.swift
//  Landmarks
//
//  Created by mtanaka on 2022/10/13.
//

import SwiftUI

struct BadgeBackground: View {
    
    var body: some View {
        // GeometryReaderでサイズ変更
        GeometryReader { geometry in
            /*
             このPath { の中に、六角形の大きさと六角形を描く開始点を指定します。
             xは横、yは縦の位置や長さを表します。
             */
            Path { path in
                // 六角形の大きさ
                var width: CGFloat = min(geometry.size.width, geometry.size.height)
                let height = width
                let xScale: CGFloat = 0.832
                let xOffset = (width * (1.0 - xScale)) / 2.0
                width *= xScale
                path.move(
                    // 線描の開始地点
                    to: CGPoint(
                        x: width * 0.95 + xOffset,
                        y: height * (0.20 + HexagonParameters.adjustment)
                    )
                )
                // HexagonParameters.swiftから六角形の描画に必要な6つの頂点を示したデータを渡します。
                HexagonParameters.segments.forEach { segment in
                    path.addLine(
                        to: CGPoint(
                            x: width * segment.line.x + xOffset,
                            y: height * segment.line.y
                        )
                    )
                    // コーナーの曲線を作る。
                    path.addQuadCurve(
                        to: CGPoint(
                            x: width * segment.curve.x + xOffset,
                            y: height * segment.curve.y
                        ),
                        control: CGPoint(
                            x: width * segment.control.x + xOffset,
                            y: height * segment.control.y
                        )
                    )
                }
            }
            // 色
            .fill(.linearGradient(
                Gradient(colors: [Self.gradientStart, Self.gradientEnd]),
                startPoint: UnitPoint(x: 0.5, y: 0.0),
                endPoint: UnitPoint(x: 0.5, y: 0.6)
            ))
        }
        // アスペクト比を維持
        .aspectRatio(1, contentMode: .fit)
    }
    static let gradientStart = Color(red: 239.0 / 255, green: 120.0 / 255, blue: 221.0 / 255)
    static let gradientEnd = Color(red: 239.0 / 255, green: 172.0 / 255, blue: 120.0 / 255)
}

struct BadgeBackground_Previews: PreviewProvider {
    static var previews: some View {
        BadgeBackground()
    }
}
